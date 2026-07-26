.psx

CustomTimeLimit:
  lw v0,0x0060(a0)  ; orig instruction
  lui at,hi(CustomTimeLimitVar)
  bne v0,r0,@@Skip
  addiu v0,r0,1  ; orig instruction
  
  lhu at,lo(CustomTimeLimitVar)(at)
  nop
  beq at,r0,@@Skip
  addiu v0,r0,0x0BB8  ; orig instruction
  add v0,at,r0
  
  @@Skip:
  j CustomTimeLimitReturn
  nop
