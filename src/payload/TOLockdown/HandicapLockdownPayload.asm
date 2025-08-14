.psx

HandicapLockdown:
  bne at,r0,@@ForceFull
  addi a0,r0,7
  lw a0,0x00F0(a1)
  lw v1,0x0128(a1)
  @@ForceFull:
  j HandicapLockdownReturn
  sw a0,0x0338(v0)
