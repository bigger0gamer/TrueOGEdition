.psx

PlayerStatePointers:
  lui at,hi(Player1StatePointer)
  beq s2,r0,@@Player1
  addi at,at,lo(Player1StatePointer)
  addi at,at,4
  
  @@Player1:
  jr v0
  sw s1,0(at)

ResetPlayerPointers:
  lui at,hi(Player1StatePointer)
  sw r0,lo(Player1StatePointer)(at)
  jr ra
  sw r0,lo(Player2StatePointer)(at)
