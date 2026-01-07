.psx

VolcanoNoErupt:
  nop
  beq v0,r0,@@Skip
  nop
  lw v0,0x0d74(s1)
  nop
  slti v0,v0,0x1000
  @@Skip:
  j VolcanoNoEruptReturn
  nop

VolcanoFastFall:
  lui v0,hi(GameplayVar)
  lbu v0,lo(GameplayVar)(v0)
  nop
  beq v0,r0,@@Skip
  addi v0,r0,0x7fff
  lw v0,0x03a8(s2)
  j VolcanoFastFallHazOnReturn
  nop
  @@Skip:
  j VolcanoFastFallHazOffReturn
  nop
