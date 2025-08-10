.psx

RevolutionNoHazards:
  lbu v0,lo(HazardsVar)(v0)
  nop
  beq v0,r0,@@Skip
  nop
  lw v0,0x0D48(s1)
  @@Skip:
  j RevolutionNoHazardsReturn
  nop

RevoSpinCooldown:
  lw at,0x0d48(s1)  ; original instruction* (at instead of v0)
  bne v0,r0,@@SkipNoHazCooldown
  slti v0,at,0x012D  ; original instruction* (at instead of v0)
  slti v0,at,30*2
  @@SkipNoHazCooldown:
  j RevoSpinCooldownReturn
  nop

ForceSpinCounterReset:
  lui at,hi(NoHazCustomVar)
  lbu at,lo(HazardsVar)(at) :: .resetdelay
  sw r0,lo(NoHazCustomVar)(at)
  bne at,r0,@@Skip
  li at,0x80073320
  addi s0,r0,0x60
  sh s0,0(at)
  addi at,at,0x10
  addi s0,r0,0xFF9F
  sh s0,0(at)
  
  @@Skip:
  j ForceSpinCounterResetReturn
  sw r0,0x0D48(s1)  ; original instruction
  

RevoFauxCeiling:
  lbu at,lo(HazardsVar)(at)
  nop
  beq at,r0,@@NoHazards
  nop
  bne v0,r0,@@HazardsNoSpin
  nop
  j RevoSpinReturn
  nop
  @@HazardsNoSpin:
  j RevoNoSpinReturn
  nop
  
  @@NoHazards:
  li at,Player2StatePointer
  lw at,0x0000(at)
  li v0,0x80107744
  lw at,0x0314(at)
  lw v0,0x0314(v0)
  blez at,@@PlayerInTopHalf
  nop
  blez v0,@@PlayerInTopHalf
  nop
  li v0,NoHazCustomVar
  lw at,0x0000(v0)
  nop
  addi at,at,-1
  sw at,0x0000(v0)
  slti at,at,0
  beq at,r0,@@SkipReset
  nop
  sw r0,0x0000(v0)
  @@SkipReset:
  j RevoNoSpinReturn
  nop
  
  @@PlayerInTopHalf:
  li v0,NoHazCustomVar
  lw at,0x0000(v0)
  nop
  addi at,at,3
  sw at,0x0000(v0)
  slti at,at,60*3
  beq at,r0,@@ForceSpin
  nop
  j RevoNoSpinReturn
  nop
  @@ForceSpin:
  addi at,r0,30*3
  j RevoSpinReturn
  sw at,0x0000(v0)
