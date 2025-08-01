; 
.psx

  ; No Lava Eruption
  .org 0x800D46FC :: VolcanoNoEruptReturn:
  .org 0x800D46F0
    lui v0,hi(HazardsVar)
    j VolcanoNoErupt
    lw v0,lo(HazardsVar)(v0)
  
  ; Lava Fast Fall
  .org 0x800D4984 :: VolcanoFastFallHazOnReturn:
  .org 0x800d498c :: VolcanoFastFallHazOffReturn:
  .org 0x800D4978
    ;subu v1,r0,v1
    ;j VolcanoFastFall



.org 0x800D48F4 :: LavaDestinationHazReturn:
.org 0x800D4A2c :: LavaDestinationNoHazReturn:
.org 0x800D48EC
  j LavaDestination
  lui at,hi(HazardsVar)
