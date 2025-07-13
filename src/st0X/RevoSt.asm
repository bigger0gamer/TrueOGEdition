; 
.psx

; 800D49EC RNG call, 1 in 512 chance of rotation every frame

  ; No Spinny spins
  .org 0x800D4CB0 :: RevolutionNoHazardsReturn:
  .org 0x800D4CA8
    j RevolutionNoHazards
    lui v0,hi(HazardsVar)
