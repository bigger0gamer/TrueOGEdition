.psx

GlacierPlatform:
  lui s3,hi(GameplayVar)
  lbu s3,lo(GameplayVar)(s3)
  nop
  beq s3,r0,@@Skip
  addi s3,r0,0x1000
  lh s3,0x1ffc(v0)
  @@Skip:
  j GlacierPlatformReturn
  ; nop (reused from below)

GlacierFastFall:
  nop
  bne v0,r0,@@Skip
  nop
  addi v0,r0,0x2
  @@Skip:
  j GlacierFastFallReturn
  nop

GlacierNoIcicles:
  lui v0,hi(GameplayVar)
  j GlacierNoIciclesReturn
  lbu v0,lo(GameplayVar)(v0)


; 800D4DE4 raise water less jank
GlacierRaiseWater:
  lbu at,lo(GameplayVar)(at)
  lw v1,0x1DD0(v0)  ; original instruction
  bne at,r0,@@Skip
  nop
  slti at,v1,0xFB00
  bne at,r0,@@Skip
  addi at,r0,2
  sw at,0x048C(s7)
  @@Skip:
  j GlacierRaiseWaterReturn
  nop
