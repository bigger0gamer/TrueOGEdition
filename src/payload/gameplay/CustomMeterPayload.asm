.psx

CustomMeterStarting:
  lbu at,lo(GameplayFlagsVar)(at)
  addi v0,r0,1
  and at,at,v0
  beq at,r0,@@Skip
  addi v0,r0,0
  lui v0,0x0001
  @@Skip:
  sw v0,0x0024(s0)  ; orig instruction
  j CustomMeterStartingReturn
  addu v0,s0,r0  ; orig instruction

CustomMeterCarry:
  lui at,hi(GameplayFlagsVar)
  lbu at,lo(GameplayFlagsVar)(at)
  addi v0,r0,2
  and at,at,v0
  beq at,r0,@@Carry
  nop
  jr ra
  nop
  @@Carry:
  j CustomMeterCarryReturn
  nop
