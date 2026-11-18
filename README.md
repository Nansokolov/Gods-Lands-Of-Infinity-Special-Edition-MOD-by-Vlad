# GODS: Lands of Infinity Special Edition - MOD by Vlad

Version 1.8. An unofficial fan mod: bug fixes, new merchants, quests, jobs, a hiring guild, respawning hunting areas, world loot, new bosses, a four-level dungeon, a new location, goblins, a witch with her own quests, walk-in houses and an inn, and party banter. Full list in `CHANGELOG.md`.

You need your own installed copy of GODS: Lands of Infinity Special Edition, and an unmodified `Gods-XP.exe`. The mod was made on one copy on Windows 11. The installer refuses other versions of the exe.

## Install
1. Run `install.bat`.
2. When asked, paste the path to the game folder, the one that contains `data.file` and the `Exe` folder. You can also drag that folder onto `install.bat`.
3. **Start a new game.** Old saves load, but most new characters and places only appear in a new game.

The installer contains no game files. It checks your `Gods-XP.exe`, then rebuilds the two mod files from your own game plus `files\mod.delta.gz`. If anything doesn't match, it stops and changes nothing. Your originals are kept in `mod_backup` inside the game folder.

It needs Windows PowerShell, which comes with Windows. If the game is in Program Files, run `install.bat` as administrator.

## Uninstall
Run `uninstall.bat` and give it the same game folder. It restores the files from `mod_backup`. Saves started with the mod may not work afterwards.

## New controls
- **Hold Shift**: 5x speed. Shift is also the default Run key.
- **Click an item on the ground**: it goes straight to the first party member with room, and drops back to the ground if nobody has room.
- **Ctrl+click an item**: the original behaviour, item on the cursor.

## Where to start
- **Petrovce**: the Sleeping Boar inn (Hilda sells food and drink and knows the latest rumours), Radoslava the Herbalist, Velimir the Mage, Radim the Hunter.
- **Marshy Land**: Baba Jaroslava's hut, four quests against the goblins.
- **Cursed Village**: a new place on the world map, west of Slavingrad.
- **Slavingrad**: Bounty Clerk, Milena the Armourer, Oswin the Arcanist, Zdenek the Bowyer, Bogumil the Guildmaster, Lord Radovan, and the Undercroft Warden, who opens the way into the four-level dungeon.
- Hand in trophies to the bounty givers to earn reputation, which unlocks better stock.

## Optional
The game can run through DXVK: put the 32-bit `d3d9.dll` from a DXVK release in the `Exe` folder. Delete it to go back.

## Known limits
- Dungeon: four levels (Undercroft, Deep Cave, Old Crypt, Endless Halls). Each keeper takes you back to Slavingrad, or deeper once that level's bosses are dead. Regular monsters return when you re-enter a level; bosses and their rewards do not.
- The maze levels have open sky: they are built inside a cleared copy of Slavingrad.
- Companion banter plays only on entering some areas.
- Clothing restored from the game's unused items rendered black, so it was left out.
- Not fully tested: gatherer restock, crafting from the new recipes, and the Grubnak and Asterion boss quests.

## Credits and third-party assets
- Building pieces and props: Kenney (Retro Fantasy Kit, Retro Textures Fantasy, Modular Cave Kit) and Kay Lousberg (KayKit Dungeon Pack), CC0.
- Stone Golem, Forest Guard, Minotaur and Mutant models: free-to-use licences from their authors, on condition that they are not used for AI training. Do not extract these models from the mod for AI training or datasets.
- Skeleton model: Vlad (made with Meshy, private licence).
- Banter writing: Vlad.

This mod is not affiliated with or endorsed by the game's developers or publisher.
