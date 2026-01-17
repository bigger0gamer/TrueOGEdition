.psx

AutoSkipKO:
  lw at,lo(0x801E7208)(at)
  addiu v1,r0,0xFFFFFFFD  ; orig instruction
  andi at,at,0x80
  beq at,r0,@@NotFinalRound
  addi v0,r0,1
  j DoNotSkipKO
  add v0,r0,r0
  @@NotFinalRound:
  j DoSkipKO
  nop
