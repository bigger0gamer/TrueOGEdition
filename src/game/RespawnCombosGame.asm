.psx

  ; Respawn Combo
  ;.org 0x80070724 :: RespawnComboReturn:
  .org 0x8007071C
    ;j RespawnCombo
    ;lui a1,hi(RespawnVar)

.org 0x800708A0 :: RespawnComboReturn:
.org 0x80070898
  j NewRespawnCombo
  lui v0,hi(RespawnVar)
