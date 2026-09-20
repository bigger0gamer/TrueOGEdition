.psx

VolcanoNoErupt:
  nop
  addi v0,v0,-2
  bne v0,r0,@@Skip
  addi v0,r0,0
  lw v0,0x0d74(s1)
  nop
  slti v0,v0,0x1000
  @@Skip:
  j VolcanoNoEruptReturn
  nop

VolcanoFastFall:
  lui v0,hi(HazardsVar)
  lbu v0,lo(HazardsVar)(v0)
  nop
  addi v0,v0,-2
  bne v0,r0,@@Skip
  addi v0,r0,0x7fff
  lw v0,0x03a8(s2)
  j VolcanoFastFallHazOnReturn
  nop
  @@Skip:
  j VolcanoFastFallHazOffReturn
  nop

VolcanoRaiseRespawn:
  lbu v0,lo(HazardsVar)(v0)
  addi at,r0,0x0401  ; original instruction-ish
  bne v0,r0,@@Skip
  lw v0,0x0004(a1)  ; original instruction
  addi at,r0,0xFAB0
  @@Skip:
  j VolcanoRaiseRespawnReturn
  nop

VolcanoWallsStageID:
  lbu v0,lo(HazardsVar)(at)
  nop
  bne v0,r0,@@Skip
  lui v0,hi(0x801e7208)
  lh v0,lo(0x801e7208)(v0)
  nop
  bne v0,r0,@@SkipStageID
  addi v0,r0,6
  sb v0,lo(StageIDVar)(at)
  
  @@SkipStageID:
  addi at,ra,0
  jal InvisibleWallsStackPrep
  addi sp,sp,-0x18
  lui a0,hi(Player1StatePointer)
  lw a0,lo(Player1StatePointer)(a0)
  li t0,0xFFEF0000
  li t1,0xFFFC0000
  li t2,0x00080000
  jal InvisibleWalls
  addi a1,r0,2
  lui a0,hi(Player2StatePointer)
  lw a0,lo(Player2StatePointer)(a0)
  jal InvisibleWalls
  addi a1,r0,2
  jal InvisibleWallsStackUnprep
  addi sp,sp,0x18
  
  @@Skip:
  lw v0,0x0D70(s1)  ; orig instruction
  j VolcanoWallsStageIDReturn
  nop
