; Well, almost everything. This handles stages, minigames, and title screen.
; Character Unlocks is under exe/EverythingUnlockedExe.asm
.psx

; Reapermon's Den Unlocked
; Stage Select: Removes branch if arcade mode hasn't been cleared
.org 0x8007913C
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
