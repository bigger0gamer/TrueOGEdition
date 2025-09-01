.psx

Versus2PLockdown:
  lbu at,lo(TOLockdown)(at)
  lhu v0,0x0004(v1)  ; orig instruction
  beq at,r0,@@Skip
  nop
  li at,0x801CED84
  beq at,t0,@@Skip
  li at,0x801E11DC
  beq at,t0,@@Skip
  nop
  lui v0,0
  @@Skip:
  j Versus2PLockdownReturn
  nop
