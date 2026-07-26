.psx

WildernessNoHazards:
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  nop
  bne v0,r0,@@Return
  addi v0,v0,-1
  
  li v0,Player1StatePointer + 0x388
  lw t7,0(v0)
  li t6,0xFFF90000
  slt t7,t7,t6
  beq t7,r0,@@Player1LeftCheck
  nop
  sw t6,0(v0)
  @@Player1LeftCheck:
  addi v0,v0,-4
  lw t7,0(v0)
  li t5,0xFFF5C000
  slt t3,t7,t5
  beq t3,r0,@@Player1RightCheck
  nop
  sw t5,0(v0)
  @@Player1RightCheck:
  li t4,0x000A0000
  slt t3,t7,t4
  bne t3,r0,@@Player2HeightCheck
  nop
  sw t4,0(v0)
  
  @@Player2HeightCheck:
  li v0,Player2StatePointer
  lw v0,0(v0)
  nop
  beq v0,r0,@@Return
  nop
  addi v0,v0,0x388
  lw t7,0(v0)
  nop
  slt t7,t7,t6
  beq t7,r0,@@Player2LeftCheck
  nop
  sw t6,0(v0)
  @@Player2LeftCheck:
  addi v0,v0,-4
  lw t7,0(v0)
  nop
  slt t3,t7,t5
  beq t3,r0,@@Player2RightCheck
  nop
  sw t5,0(v0)
  @@Player2RightCheck:
  nop
  slt t3,t7,t4
  bne t3,r0,@@Resetv0
  nop
  sw t4,0(v0)
  @@Resetv0:
  add v0,r0,r0
  
  @@Return:
  j WildernessNoHazardsReturn
  nop


WildMoveRespawns:
  addi at,r0,1
  bne at,a2,@@Return
  addiu v0,v0,0x4FE4  ; orig instruction
  
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@Return
  nop
  
  addi v0,v0,-0x50
  
  @@Return:
  j WildMoveRespawnsReturn
  nop
