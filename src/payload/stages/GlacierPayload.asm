.psx

GlacierPlatform:
  lui s3,hi(HazardsVar)
  lbu s3,lo(HazardsVar)(s3)
  nop
  addi s3,s3,-2
  bne s3,r0,@@Skip
  addi s3,r0,0x1000
  lh s3,0x1ffc(v0)
  @@Skip:
  j GlacierPlatformReturn
  ; nop (reused from below)

GlacierFastFall:
  nop
  addi v0,v0,-2
  beq v0,r0,@@Skip
  addi v0,r0,1
  addi v0,r0,0x2
  @@Skip:
  j GlacierFastFallReturn
  nop

GlacierNoIciclesInitialize:
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  j GlacierNoIciclesInitializeReturn
  srl v0,v0,1

GlacierNoIciclesLoop:
  j GlacierNoIciclesLoopReturn
  sw v0,0x0000(v1)  ; orig instruction
