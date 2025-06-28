.psx

GlacierPlatform:
  lui s3,hi(HazardsVar)
  lw s3,lo(HazardsVar)(s3)
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
  lui v0,hi(HazardsVar)
  j GlacierNoIciclesReturn
  lw v0,lo(HazardsVar)(v0)
