.psx

ScoreDisplay:
  addi v0,r0,2
  beq v0,t7,@@Skip
  lw v0,0x0334(v1)  ; orig instruction
  
  sll t7,a1,2
  add at,at,t7
  lw v0,lo(0x801E7180)(at)
  
  @@Skip:
  jr ra
  nop
