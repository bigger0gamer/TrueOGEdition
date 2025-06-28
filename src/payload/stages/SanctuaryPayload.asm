.psx

SanctuaryNoHazards:
  lw v0,lo(HazardsVar)(v0)
  nop
  bne v0,r0,@@HazardsOn
  nop
  j SanctuaryHazOffReturn
  addi v0,v0,0x1
  @@HazardsOn:
  lw v0, 0x0d54(s0)
  j SanctuaryHazOnReturn
  nop

NightSanctuary:
  lui v0,hi(HazardsVar)
  lw v0,lo(HazardsVar)(v0)
  nop
  bne v0,r0,@@HazardsOn
  lui v0,0x8006
  lw v0,0x2198(v0)
  nop
  andi v0,v0,0xE
  bne v0,r0,@@HazardsOn
  nop
  j NightSanctuaryReturn
  addiu v0,r0,0x0020
  @@HazardsOn:
  j NightSanctuaryReturn
  addiu v0,r0,0x0080
