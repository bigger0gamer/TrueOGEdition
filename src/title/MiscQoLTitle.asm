.psx

; Default to "YES" on "Finish loading?" at inital boot without memory card
; Makes it easy to mash :bx: to the title screen
.org 0x8006F218
  addi a1,r0,0x1  ; 1 "YES" instead of 0 "NO"

; Allow mirror match without holding Select: Removes branch if character already selected
.org 0x80074910
  nop

; Bottom Row Evos Available in 1P Arcade Mode: nops what overwrites bottom row evos as locked
.org 0x80074434
  nop
