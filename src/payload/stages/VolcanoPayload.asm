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
  lui v0,hi(HazardsVar)
  lw v0,lo(HazardsVar)(v0)
  nop
  beq v0,r0,@@Skip
  addi v0,r0,0x7fff
  lw v0,0x03a8(s2)
  j VolcanoFastFallHazOnReturn
  nop
  @@Skip:
  j VolcanoFastFallHazOffReturn
  nop

LavaDestination:
  lw at,lo(HazardsVar)(at)
  lw v1,0x0014(sp)  ; original instruction
  bne at,r0,@@Skip
  slti at,v1,0xF800
  beq at,r0,@@NoTouchy
  lw v0,0x0310(s0)
  nop
  slti at,v0,0xFBB0
  bne at,r0,@@NoTouchy
  slti at,v0,0x0800
  bne at,r0,@@Touchy
  nop
  
  @@NoTouchy:
  addi at,r0,2
  sw at,0x048C(s0)
  @@Touchy:
  j LavaDestinationNoHazReturn
  nop
  
  @@Skip:
  j LavaDestinationHazReturn
  nop
