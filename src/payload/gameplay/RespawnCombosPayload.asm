.psx

; Setting loaded from RespawnVar
; 0 - Respawn Combos Enabled
; 1 - Respawn Combos Disabled

; Main function!
RespawnCombo:
  lw a1,lo(RespawnVar)(a1)  ; Load respawn combo setting
  addu a0,s1,r0             ; orig instruction
  beq a1,r0,@@branch        ; If 0, we skip the instruction that disables respawns
  lui a1,0x4000             ; Gives respawns original "launcher" property
  lui a1,0x8000             ; Overwrite respawn property with "knockdown" (disables respawn combos)
  
  @@branch:
  j RespawnComboReturn      ; Return back to game.bin
  nop
