.psx



; Character Bans
; We just don't save w/e BS the game does to figure out unlocked characters
.org 0x800743E8
  nop
.org 0x80074404
  nop

; Highjack a method call to fill in the character table ourselves
; then return to the original called method
.org 0x80074394
  add a3,r0,r0
.org 0x8007439C
  jal FillCharacterTable
.org 0x8012AB34 :: CharacterTable:



; Stage Bans
; 
.org 0x8007917C :: StageBannedReturn:
.org 0x800792B0 :: StageBansNotEqualReturn:
.org 0x800792C8 :: StageBansEqualReturn:
.org 0x800792A8
  j StageBans
  lw v0,0x01AC(s1)  ; "orig instruction"



; Force 8/8 Handicap
.org 0x800761F0 :: HandicapLockdownReturn:
.org 0x800761DC
  lui at,hi(TOLockdown)
  lbu at,lo(TOLockdown)(at)
  addiu v0,v0,0xF8B8  ; orig instruction
  j HandicapLockdown
  addi v1,r0,7
