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
  
  addi at,ra,0
  jal InvisibleWallsStackPrep
  addi sp,sp,-0x18
  lui a0,hi(Player1StatePointer)
  lw a0,lo(Player1StatePointer)(a0)
  li t0,0xFFF80000
  li t1,0xFFF90000
  li t2,0x00070000
  jal InvisibleWalls
  addi a1,r0,2
  lui a0,hi(Player2StatePointer)
  lw a0,lo(Player2StatePointer)(a0)
  jal InvisibleWalls
  addi a1,r0,2
  jal InvisibleWallsStackUnprep
  addi sp,sp,0x18
  
  ;lui v0,0
  lui s0,0
  
  @@Skip:
  lui ra,hi(ReapersNoMoveOrbReturn)
  j 0x800700CC
  addi ra,lo(ReapersNoMoveOrbReturn)
