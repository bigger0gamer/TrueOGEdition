.psx

RevolutionNoHazards:
  lbu v0,lo(GameplayVar)(v0)
  nop
  beq v0,r0,@@SkipHazards
  nop
  j @@Return
  lw v0,0x0D48(s1)
  @@SkipHazards:
  li v0,Player1StatePointer + 0x388
  lw t7,0(v0)
  nop
  slt t7,t7,r0
  beq t7,r0,@@Player2Check
  nop
  sw r0,0(v0)
  @@Player2Check:
  li v0,Player2StatePointer
  lw v0,0(v0)
  nop
  beq v0,r0,@@Return
  nop
  addi v0,v0,0x388
  lw t7,0(v0)
  nop
  slt t7,t7,r0
  beq t7,r0,@@Resetv0
  nop
  sw r0,0(v0)
  @@Resetv0:
  add v0,r0,r0
  
  @@Return:
  j RevolutionNoHazardsReturn
  nop
