.psx

; No Spinny spins
.org 0x800D4CB0 :: RevolutionNoHazardsReturn:
.org 0x800D4CA8
  j RevolutionNoHazards
  lui v0,hi(HazardsVar)
