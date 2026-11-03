# GODS: Lands of Infinity SE - MOD by Vlad. Rebuilds patch.file and Gods-XP.exe from the player's own game plus files\mod.delta.
param([string]$GameDir)
$ErrorActionPreference = 'Stop'
$cs = @'
using System; using System.IO; using System.Text; using System.Security.Cryptography; using System.Collections.Generic;
public static class GodsMod {
  const string ExeSha = "bb4e9235c6a0c5451f31ce91ca28e1d387c6174ba70ea26c319f9cd158b2acdb";
  static string Hex(byte[] b){ StringBuilder s=new StringBuilder(); foreach(byte x in b) s.Append(x.ToString("x2")); return s.ToString(); }
  public static string FileSha(string p){ using(SHA256 h=SHA256.Create()) using(FileStream f=File.OpenRead(p)) return Hex(h.ComputeHash(f)); }
  public static bool IsOriginalExe(string p){ return FileSha(p)==ExeSha; }
  static void Pump(Stream from,long off,long len,Stream to,HashAlgorithm h,byte[] buf){
    from.Seek(off,SeekOrigin.Begin);
    while(len>0){ int n=from.Read(buf,0,(int)Math.Min(len,buf.Length)); if(n<=0) throw new Exception("Your game files are smaller than expected.");
      to.Write(buf,0,n); h.TransformBlock(buf,0,n,null,0); len-=n; }
  }
  // Writes each output to tmpDir. Returns the list of relative output names. Throws if any result differs from the expected hash.
  public static string[] Build(string delta,string dataFile,string patchFile,string exeFile,string tmpDir){
    List<string> names=new List<string>(); byte[] buf=new byte[1<<20];
    using(BinaryReader r=new BinaryReader(File.OpenRead(delta))){
      if(Encoding.ASCII.GetString(r.ReadBytes(8))!="GODSMOD1") throw new Exception("mod.delta is damaged.");
      uint outputs=r.ReadUInt32();
      Stream[] src=new Stream[]{File.OpenRead(dataFile),File.OpenRead(patchFile),File.OpenRead(exeFile)};
      try{
        for(uint k=0;k<outputs;k++){
          string name=Encoding.ASCII.GetString(r.ReadBytes(r.ReadByte())); long size=r.ReadInt64(); string want=Hex(r.ReadBytes(32)); uint nOps=r.ReadUInt32();
          byte[] op=r.ReadBytes((int)nOps*13); long blobLen=r.ReadInt64(); long blobStart=r.BaseStream.Position;
          string outPath=Path.Combine(tmpDir,name.Replace('\\','_'));
          using(SHA256 h=SHA256.Create()) using(FileStream o=File.Create(outPath)){
            for(int i=0;i<nOps;i++){ byte s=op[i*13]; long off=BitConverter.ToInt64(op,i*13+1); uint len=BitConverter.ToUInt32(op,i*13+9);
              if(s==255) Pump(r.BaseStream,blobStart+off,len,o,h,buf); else Pump(src[s],off,len,o,h,buf); }
            h.TransformFinalBlock(buf,0,0);
            if(o.Length!=size||Hex(h.Hash)!=want) throw new Exception(name+" did not rebuild correctly. Your data.file or patch.file is a different version from the one this mod supports.");
          }
          r.BaseStream.Seek(blobStart+blobLen,SeekOrigin.Begin); names.Add(name);
        }
      } finally { foreach(Stream s in src) s.Dispose(); }
    }
    return names.ToArray();
  }
}
'@
Add-Type -TypeDefinition $cs -Language CSharp
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
try {
  if (-not $GameDir) { $GameDir = Read-Host 'Paste the game folder (the one with data.file and the Exe folder)' }
  $GameDir = $GameDir.Trim().Trim('"').TrimEnd('\')
  foreach ($f in 'data.file','patch.file','Exe\Gods-XP.exe') {
    if (-not (Test-Path -LiteralPath (Join-Path $GameDir $f))) { throw "$f was not found in $GameDir" }
  }
  $bak = Join-Path $GameDir 'mod_backup'
  $fresh = $false
  $srcExe = Join-Path $bak 'Gods-XP.exe'; $srcPatch = Join-Path $bak 'patch.file'
  if (-not ((Test-Path -LiteralPath $srcExe) -and (Test-Path -LiteralPath $srcPatch))) {
    $srcExe = Join-Path $GameDir 'Exe\Gods-XP.exe'; $srcPatch = Join-Path $GameDir 'patch.file'
    $fresh = $true
  }
  Write-Host 'Checking your game...'
  if (-not [GodsMod]::IsOriginalExe($srcExe)) { throw 'Your Gods-XP.exe is not the version this mod supports, or it is already modified. Nothing was changed.' }
  $tmp = Join-Path $GameDir 'mod_tmp'
  New-Item -ItemType Directory -Force -Path $tmp | Out-Null
  Write-Host 'Building the mod files...'
  [void][GodsMod]::Build((Join-Path $here 'files\mod.delta'), (Join-Path $GameDir 'data.file'), $srcPatch, $srcExe, $tmp)
  if ($fresh) {
    New-Item -ItemType Directory -Force -Path $bak | Out-Null
    Copy-Item -LiteralPath $srcExe -Destination (Join-Path $bak 'Gods-XP.exe') -Force
    Copy-Item -LiteralPath $srcPatch -Destination (Join-Path $bak 'patch.file') -Force
    Write-Host 'Originals saved in mod_backup.'
  }
  Move-Item -LiteralPath (Join-Path $tmp 'patch.file') -Destination (Join-Path $GameDir 'patch.file') -Force
  Move-Item -LiteralPath (Join-Path $tmp 'Exe_Gods-XP.exe') -Destination (Join-Path $GameDir 'Exe\Gods-XP.exe') -Force
  Remove-Item -LiteralPath $tmp -Recurse -Force
  Write-Host ''
  Write-Host 'Mod installed. Start a NEW GAME to see the new content.'
} catch {
  if ($tmp -and (Test-Path -LiteralPath $tmp)) { Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue }
  Write-Host ''
  Write-Host "Install stopped: $($_.Exception.Message)"
  Write-Host 'If the game is in Program Files, run install.bat as administrator.'
}
