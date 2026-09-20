.psx

RevolutionNoHazards:
  lbu v0,lo(HazardsVar)(v0)
  nop
  beq v0,r0,@@SkipHazards
  addi v0,v0,-1
  beq v0,r0,@@Return
  add v0,r0,r0
  j @@Return
  lw v0,0x0D48(s1)
  @@SkipHazards:
  
  addi at,ra,0
  jal InvisibleWallsStackPrep
  addi sp,sp,-0x18
  lui a0,hi(Player1StatePointer)
  lw a0,lo(Player1StatePointer)(a0)
  lui t0,0
  jal InvisibleWalls
  addi a1,r0,1
  lui a0,hi(Player2StatePointer)
  lw a0,lo(Player2StatePointer)(a0)
  jal InvisibleWalls
  addi a1,r0,1
  jal InvisibleWallsStackUnprep
  addi sp,sp,0x18
  
  @@Return:
  j RevolutionNoHazardsReturn
  nop
