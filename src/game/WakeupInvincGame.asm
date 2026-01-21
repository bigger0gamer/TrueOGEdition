.psx

.org 0x80081B20 :: WakeupInvincReturn:
.org 0x80081B18
  j WakeupInvinc
  addiu a1,r0,1  ; orig instruction
  lw v1,0x0008(s0)  ; orig instruction
