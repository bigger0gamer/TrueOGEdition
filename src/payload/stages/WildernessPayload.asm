.psx

WildernessNoHazards:
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  nop
  bne v0,r0,@@Return
  addi v0,v0,-1
  
  addi at,ra,0
  jal InvisibleWallsStackPrep
  addi sp,sp,-0x18
  lui a0,hi(Player1StatePointer)
  lw a0,lo(Player1StatePointer)(a0)
  li t0,0xFFF90000
  li t1,0xFFF5C000
  li t2,0x000A0000
  jal InvisibleWalls
  addi a1,r0,2
  lui a0,hi(Player2StatePointer)
  lw a0,lo(Player2StatePointer)(a0)
  jal InvisibleWalls
  addi a1,r0,2
  jal InvisibleWallsStackUnprep
  addi sp,sp,0x18
  
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
