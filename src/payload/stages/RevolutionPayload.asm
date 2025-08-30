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

RevoStartRoundVarsReset:
  lui at,hi(NoHazCustomVar)
  lbu at,lo(HazardsVar)(at) :: .resetdelay
  sw r0,lo(NoHazCustomVar)(at)
  bne at,r0,@@Skip
  li at,0x80070720
  addi s0,r0,0x2000
  sh s0,0(at)
  
  @@Skip:
  j ForceSpinCounterResetReturn
  sw r0,0x0D48(s1)  ; original instruction

RevoForceRespawn:
  lbu at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@Skip
  lw v0,0x0004(a1)
  jr ra
  slti v0,v0,0xFF30
  
  @@Skip:
  j RevoForceRespawnReturn
  nop
