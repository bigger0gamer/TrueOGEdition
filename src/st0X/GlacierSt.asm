.psx

; Reinforce Breakoff Platforms
.org 0x800D5A84 :: GlacierPlatformReturn:
.org 0x800D5A7C
  j GlacierPlatform
  sw s0, 0x0010(sp)  ; orig instruction?

; Ice Water Fast Fall
.org 0x800D4DD0 :: GlacierFastFallReturn:
.org 0x800D4DC4
  lui v0,hi(HazardsVar)
  j GlacierFastFall
  lbu v0,lo(HazardsVar)(v0)

; No Icicles
.org 0x800D500C :: GlacierNoIciclesInitializeReturn:
.org 0x800D5004
  j GlacierNoIciclesInitialize

.org 0x800D55CC :: GlacierNoIciclesLoopReturn:
.org 0x800D5348
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  sll s2,s4,4  ; orig instruction
  j GlacierNoIciclesLoop
  srl v0,v0,1
