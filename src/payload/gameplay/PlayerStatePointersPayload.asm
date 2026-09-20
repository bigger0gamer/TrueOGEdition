.psx

PlayerStatePointers:
  lui at,hi(Player1StatePointer)
  beq s2,r0,@@Player1
  addi at,at,lo(Player1StatePointer)
  addi at,at,4
  
  @@Player1:
  jr v0
  sw s1,0(at)
