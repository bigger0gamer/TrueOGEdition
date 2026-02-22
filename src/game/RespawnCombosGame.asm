.psx

; New Respawn combos hook
.org 0x800708A0 :: NewRespawnComboReturn:
.org 0x80070898
  j NewRespawnCombo
  lui v0,hi(RespawnVar)



; Old Respawn Combos hook
/*
.org 0x80070724 :: RespawnComboReturn:
.org 0x8007071C
  j RespawnCombo
  lui a1,hi(RespawnVar)
*/
