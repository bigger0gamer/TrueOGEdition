.psx

ForceWinQuote:
  beq at,r0,@@DontForce
  nop
  add v0,r0,r0
  ; reset StageIDVar at end of match
  lui at,hi(StageIDVar)
  sb r0,lo(StageIDVar)(at)
  
  @@DontForce:
  andi v0,v0,0x0800  ; original instruction
  beq v0,r0,@@NoSkip
  nop
  j DidSkip
  nop
  @@NoSkip:
  j DidNotSkip
  nop
