.psx

; Black Void (Round 1)
; Left here for convinience
;.org 0x800D43D0
;  addiu a2,r0,0

; No blur (Rounds 2+)
.org 0x800D4A7C
  addi a2,r0,0
  addi a3,r0,0

; No blur (Round 1)
.org 0x800D48C8
  addi a2,r0,0
  addi a3,r0,0xFF
