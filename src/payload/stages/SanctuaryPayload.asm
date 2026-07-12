.psx

SanctuaryNoHazards:
  lbu v0,lo(HazardsVar)(v0)
  nop
  addi v0,v0,-2
  beq v0,r0,@@HazardsOn
  addi v0,v0,1
  beq v0,r0,@@NoCeiling
  nop
  
  li v0,Player1StatePointer + 0x388
  lw t7,0(v0)
  li t6,0xFFEF0000
  slt t7,t7,t6
  beq t7,r0,@@Player2Check
  nop
  sw t6,0(v0)
  @@Player2Check:
  li v0,Player2StatePointer
  lw v0,0(v0)
  nop
  beq v0,r0,@@NoCeiling
  nop
  addi v0,v0,0x388
  lw t7,0(v0)
  nop
  slt t7,t7,t6
  beq t7,r0,@@NoCeiling
  nop
  sw t6,0(v0)
  
  @@NoCeiling:
  j SanctuaryHazOffReturn
  addi v0,r0,0x1
  @@HazardsOn:
  lw v0, 0x0d54(s0)
  j SanctuaryHazOnReturn
  nop

NightSanctuary:
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  nop
  addi v0,v0,-2
  beq v0,r0,@@HazardsOn
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
