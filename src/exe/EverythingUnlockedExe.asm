.psx

; All Characters Unlocked
; Character Select: Sets all bits in a0 instead of loading unlocked characters from RAM (lazy)
.org 0x8001D31C
  addi a0,r0,-1
