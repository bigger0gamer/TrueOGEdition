.psx

ForceWinQuote:
  beq at,r0,@@DontForce
  nop
  add v0,r0,r0
  
  @@DontForce:
  andi v0,v0,0x0800  ; original instruction
  beq v0,r0,@@NoSkip
  nop
  j DidSkip
  nop
  @@NoSkip:
  j DidNotSkip
  nop
