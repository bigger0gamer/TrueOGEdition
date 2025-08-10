.psx

;     - 0x8006759C - prevent entering anything but 2P VS
;       a0 = 801CED84 -> Entering 2P VS  



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
