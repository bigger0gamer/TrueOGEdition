; Well, almost everything. This handles stages, minigames, and title screen.
; Character Unlocks is under exe/EverythingUnlockedExe.asm
.psx

; Reapermon's Den & Basketball available in 2P VS
.org 0x80079130
  addiu s0,r0,7
  addu s4,v0,r0
  nop
  nop
  nop
  nop
  

; Minigames Unlocked
; Main Menu: Removes branch if no minigames have been unlocked
.org 0x800678E0
  nop

; Stage Select: Removes branches if next minigame isn't unlocked
.org 0x80079240
  nop  ; Left
.org 0x800792A0
  nop  ; Right
