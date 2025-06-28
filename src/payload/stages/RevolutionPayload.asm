.psx

RevolutionNoHazards:
  lw v0,lo(HazardsVar)(v0)
  nop
  beq v0,r0,@@Skip
  nop
  lw v0,0x0D48(s1)
  @@Skip:
  j RevolutionNoHazardsReturn
  nop
