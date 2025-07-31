; 
.psx

  ; Reinforce Breakoff Platforms
  .org 0x800D5A84 :: GlacierPlatformReturn:
  .org 0x800D5A7C :: GlacierPlatformCut:
    j GlacierPlatform
    sw s0, 0x0010(sp)
  
  ; Ice Water Fast Fall
  .org 0x800D4DD0 :: GlacierFastFallReturn:
  .org 0x800D4DC4 :: GlacierFastFallCut:
    lui v0,hi(HazardsVar)
    j GlacierFastFall
    lw v0,lo(HazardsVar)(v0)
  
  ; No Icicles
  .org 0x800D500C :: GlacierNoIciclesReturn:
  .org 0x800D5004 :: GlacierNoIciclesCut:
    j GlacierNoIcicles
  .org 0x800D5348
    sll s2,s4,4
    lui v0,hi(HazardsVar)
    lw v0,lo(HazardsVar)(v0)



.org 0x800D4D34 :: GlacierRaiseWaterReturn:
.org 0x800D4D2C
  j GlacierRaiseWater
  lui at,hi(HazardsVar)
