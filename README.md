# True OG Edition

True OG Edition is a "Tournament Edition" style ROM hack for Digimon Rumble Arena with the following features.

- Options to change
  - Items On/Off
  - Stage Hazards On/Off
  - Physics No Ice/Original/All Ice
  - Respawn Combos On/Off
- Quality of Life Additions
  - Everything Unlocked (No Save File)
  - Random Character (Press Start)
  - Random Stage (Press Start)
  - Random Music
  - Alternate Digimon Colors (Hold Select or R1, Select Digimon)
  - Allow Mirror Matches (Without Holding Select)
- And more!

## How To Play

Coming soon, to a releases page near you! (PPF patch file)

## Building (Only 4 Hackers!)

If you only want to play the ROM hack, check the How To Play section. If you'd like to help expanding the mod, here's how to build the hack for yourself.

### Dependencies

You will need to install the following:

- [armips](https://github.com/Kingcom/armips) v0.11 or newer
- [psximager](https://github.com/cebix/psximager) v2.2 or newer
- [quickbms] (https://aluigi.altervista.org/quickbms.htm) v0.11.0 or newer
- A PS1 emulator with debugger of your choice. I personally use [mednafen](https://mednafen.github.io/), but feel free to use whatever you'd like, but being able to launch a game from command line will be desired.
- A text editor, probably.

This project assumes you are using a flavor of Linux, and only provides bash scripts. Windows and MacOS will suffice, but you will have to make your own build script modeled after the included one.

### Setup the build environment

You will need to provide a clean copy of Digimon Rumble Arena. Place it in the `/build env` dir, and run `/build env/extract.sh`, and everything should be setup for you.

### Changing the Title ID

At the start of `/src/build.sh`, you will find a line creating a `TITLE_ID` variable. This will allow you to easily rename the game's Title ID. This is useful for both having the modified output of `SLUS_014.04` be saved to a unique file, as well as for the output ROM to have a unique Title ID in emulators such as Duckstation to make it easier to distinguish from the original game, as well as being a requirement to add a ROM hack to [Arkadyzja](https://arkadyzja.honmaru.pl/). For testing purposes, I use `TRUE_OGD.EV`, but I would change this to something including the version number when you're ready for release, such as `TRUE_OG1.12`.

### Building

This should be as simple as running `/src/build.sh`, but the basic overview is thus:

```
armips TrueOG.asm
cd ../build\ env
quickbms -w -r digimon_vfs2.bms "Digimon Rumble Arena (US)/A.VFS" "Digimon Rumble Arena (US)/inject"
psxbuild -c "Digimon Rumble Arena (US).cat" TrueOG.bin
*open TrueOG.cue in your emulator here*
```

This will build assemble the hack, insert any necessary files into the game's compressed file system, and build a new disc image based on the resulting output. Automatically opening it in an emulator to test out new changes will be convienent. This is of course, somewhat abridged, as this glosses over how `build.sh` makes temporary edits to various files to change the Title ID as mentioned in the last section on the fly, so you should reference `build.sh` if you should need to change it, or rewrite it for your OS.

## Credits

DarkChaosBlast - For making the QuickBMS script that made extracting and injecting A.VFS's files possible. I'm not sure I'd have ever been able to bust this file open myself!

The developer of mednafen - for making my favorite emulator by miles, especially for PS1. Thank you, anonymous coward.

Kingcom - for making armips. Holy *fuck* is this such a great and powerful tool for PS1 ROM hacking. It is far and away better than what I was doing for previous versions of this hack, and I never could have made such a good tool on my own. Thank you.

kjn1 & the writers of "The Secrets of Gameshark Hacking" - Though this project represents my modding efforts moving past long spaghetti cheat codes into a "proper" ROM hack, it's kjn1's Joker Command & Alt Digimon Color cheat codes that ultimatly got me inspired back in late 2020 to start improving DRA's competitive experience, and "The Secrets of Gameshark Hacking" was an invaluable resource back when "True OG Edition" was still just "the Netplay Pack".
