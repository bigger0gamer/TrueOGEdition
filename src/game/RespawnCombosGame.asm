.psx

  ; Respawn Combo
  .org 0x80070724 :: RespawnComboReturn:
  .org 0x8007071C
    j RespawnCombo
    lui a1,hi(RespawnVar)
