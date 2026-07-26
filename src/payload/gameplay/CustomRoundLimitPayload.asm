.psx

CustomRoundLimit:
  lbu at,lo(CustomRoundLimitVar)(at)
  addiu v1,r0,2  ; orig instruction
  beq at,r0,@@Skip
  addiu v0,r0,5  ; orig instruction
  add v1,at,r0
  @@Skip:
  j CustomRoundLimitReturn
  nop
