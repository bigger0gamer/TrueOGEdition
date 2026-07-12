.psx

ReapersRoundOne:
  lui v1,hi(HazardsVar)
  lbu v1,lo(HazardsVar)(v1)
  nop
  beq v1,r0,@@Skip
  nop
  lw v1,0x0D70(s2)  ; orig instruction
  
  @@Skip:
  j ReapersRoundOneReturn
  nop

ReapersWallSelector:
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  beq at,r0,@@Skip
  nop
  j 0x80077654
  nop
  
  @@Skip:
  jr ra
  nop

ReapersOrbSize:
  slti at,a2,0x50
  bne at,r0,@@Skip
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@Skip
  nop
  
  addi a2,r0,0x50
  
  @@Skip:
  j 0x800D4714
  nop

ReapersNoMoveOrb:
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@Skip
  nop
  
  lui s0,0
  li v0,Player1StatePointer + 0x388
  lw t7,0(v0)
  li t6,0xFFF80000
  slt t7,t7,t6
  beq t7,r0,@@Player1LeftCheck
  nop
  sw t6,0(v0)
  @@Player1LeftCheck:
  addi v0,v0,-4
  lw t7,0(v0)
  li t5,0xFFF90000
  slt t3,t7,t5
  beq t3,r0,@@Player1RightCheck
  nop
  sw t5,0(v0)
  @@Player1RightCheck:
  li t4,0x00070000
  slt t3,t7,t4
  bne t3,r0,@@Player2HeightCheck
  nop
  sw t4,0(v0)
  
  @@Player2HeightCheck:
  li v0,Player2StatePointer
  lw v0,0(v0)
  nop
  beq v0,r0,@@Skip
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
  
  @@Skip:
  lui ra,hi(ReapersNoMoveOrbReturn)
  j 0x800700CC
  addi ra,lo(ReapersNoMoveOrbReturn)
