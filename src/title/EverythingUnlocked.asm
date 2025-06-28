; Well, almost everything. This handles stages, minigames, and title screen.
; Character Unlocks is under the main exe
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


; TODO move elsewhere, maybe get it to not load at inital boot at all?
; Default to "YES" on "Continue Loading?" at inital boot without memory card
.org 0x8006F218
  addi a1,r0,0x1  ; 1 "YES" instead of 0 "NO"

; TODO move elsewhere, these don't relate to unlocks
; Allow mirror match without holding Select: Removes branch if character already selected
.org 0x80074910
  nop


; Bottom Row Evos Available in 1P Arcade Mode: nops what overwrites bottom row evos as locked
.org 0x80074434
  nop
