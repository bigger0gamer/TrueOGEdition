.psx

; safe registers: at, a1, a2, a3, v0, v1, t0, t1
; at - stage bans
; a1 - bit mask
; a2 - bit mask and result
; a3 - Char ID counter
; v0 - character table pointer
FillCharacterTable:
  lui at,hi(CharacterStageBans)
  lw at,lo(CharacterStageBans)(at)
  addi a1,r0,1
  li v0,CharacterTable
  
  @@Loop:
  and a2,at,a1
  slti a2,a2,1
  sw a2,0x0000(v0)
  
  addi v0,v0,4
  addi a3,a3,1
  slti a2,a3,24
  bne a2,r0,@@Loop
  srl at,at,1
  
  j 0x8001D2A4
  nop
