@echo off
setlocal
title GODS LoI SE - MOD by Vlad - Uninstall
set "GAME=%~1"
if not "%GAME%"=="" goto check
echo Paste the game folder (the one with data.file and the Exe folder), then press Enter.
set /p "GAME=Game folder: "
:check
set "GAME=%GAME:"=%"
if exist "%GAME%\mod_backup\Gods-XP.exe" goto found
echo.
echo No mod_backup folder in "%GAME%". Nothing was changed.
goto done
:found
copy /Y "%GAME%\mod_backup\Gods-XP.exe" "%GAME%\Exe\Gods-XP.exe" >nul
if errorlevel 1 goto failed
if exist "%GAME%\mod_backup\patch.file" copy /Y "%GAME%\mod_backup\patch.file" "%GAME%\patch.file" >nul
if errorlevel 1 goto failed
echo.
echo Original files restored.
goto done
:failed
echo.
echo Copy failed. If the game is in Program Files, run this as administrator.
:done
echo.
pause
