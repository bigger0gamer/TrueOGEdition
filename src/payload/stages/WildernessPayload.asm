.psx

WildernessNoHazards:
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  j WildernessNoHazardsReturn
  nop
