.psx

Player2InputFix:
  li at,Player2LateInputs
  bne s1,at,@@Return
  li at,Player2RealInputs
  lbu v0,0x0000(at)
  j Player2InputFixReturn
  lbu v1,0x0001(at)
  
  @@Return:
  lbu v0,0x0002(s1)  ; orig instruction
  j Player2InputFixReturn
  lbu v1,0x0003(s1)  ; orig instruction
