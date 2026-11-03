# GODS: Lands of Infinity Special Edition - MOD by Vlad

Version 1.5.2. An unofficial fan mod: bug fixes, new merchants, quests, jobs, a hiring guild, respawning hunting areas, world loot, new bosses and a small dungeon. Full list in `CHANGELOG.md`.

You need your own installed copy of GODS: Lands of Infinity Special Edition, and an unmodified `Gods-XP.exe`. The mod was made on one copy on Windows 11. The installer refuses other versions of the exe.

## Install
1. Run `install.bat`.
2. When asked, paste the path to the game folder, the one that contains `data.file` and the `Exe` folder. You can also drag that folder onto `install.bat`.
3. **Start a new game.** Old saves load, but most new characters and places only appear in a new game.

The installer contains no game files. It checks your `Gods-XP.exe`, then rebuilds the two mod files from your own game plus the small `files\mod.delta`. If anything doesn't match, it stops and changes nothing. Your originals are kept in `mod_backup` inside the game folder.

It needs Windows PowerShell, which comes with Windows. If the game is in Program Files, run `install.bat` as administrator.

## Uninstall
Run `uninstall.bat` and give it the same game folder. It restores the files from `mod_backup`. Saves started with the mod may not work afterwards.

## New controls
- **Hold Shift**: 5x speed. Shift is also the default Run key.
- **Click an item on the ground**: it goes straight to the first party member with room, and drops back to the ground if nobody has room.
- **Ctrl+click an item**: the original behaviour, item on the cursor.

## Where to start
- **Petrovce**: Radoslava the Herbalist, Velimir the Mage, Radim the Hunter.
- **Slavingrad**: Bounty Clerk, Milena the Armourer, Oswin the Arcanist, Zdenek the Bowyer, Bogumil the Guildmaster, Lord Radovan, the Undercroft Warden.
- Hand in trophies to the bounty givers to earn reputation, which unlocks better stock.

## Optional
The game can run through DXVK: put the 32-bit `d3d9.dll` from a DXVK release in the `Exe` folder. Delete it to go back.

## Known limits
- Dungeon: 16 monsters plus a boss. The map post can also be used to leave it.
- Clothing restored from the game's unused items rendered black, so it was left out.
- Not fully tested: gatherer restock, crafting from the new recipes, and the Grubnak and Asterion boss quests.

This mod is not affiliated with or endorsed by the game's developers or publisher.
