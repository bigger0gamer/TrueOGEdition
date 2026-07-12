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
  li v0,Player1StatePointer + 0x388
  lw t7,0(v0)
  li t6,0xFFEF0000
  slt t7,t7,t6
  beq t7,r0,@@Player1LeftCheck
  nop
  sw t6,0(v0)
  @@Player1LeftCheck:
  addi v0,v0,-4
  lw t7,0(v0)
  li t5,0xFFFC0000
  slt t3,t7,t5
  beq t3,r0,@@Player1RightCheck
  nop
  sw t5,0(v0)
  @@Player1RightCheck:
  li t4,0x00080000
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
  bne t3,r0,@@Skip
  nop
  sw t4,0(v0)
  
  @@Skip:
  lw v0,0x0D70(s1)  ; orig instruction
  j VolcanoWallsStageIDReturn
  nop
