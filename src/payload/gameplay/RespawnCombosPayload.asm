.psx

; Setting loaded from RespawnVar
; 1 - Respawn Combos Enabled
; 0 - Respawn Combos Disabled

; New function!
; This increases the respawn invincibility that apparently was always there
; from a measily 3 frames, up to something actually long enough to keep players safe
NewRespawnCombo:
  lbu v0,lo(RespawnVar)(v0)
  lw ra,0x0024(sp)  ; orig instruction
  bne v0,r0,@@Skip
  addiu v0,r0,3
  addiu v0,r0,17
  @@Skip:
  j NewRespawnComboReturn
  nop



; Old function
; This forces knockdown on respawn, which prevents respawn combos
; but also shortens wake up times, which isn't desirable
; Still has 0 = respawn on, unused and for reference lol
/*
RespawnCombo:
  lbu a1,lo(RespawnVar)(a1)  ; Load respawn combo setting
  addu a0,s1,r0             ; orig instruction
  beq a1,r0,@@branch        ; If 0, we skip the instruction that disables respawns
  lui a1,0x4000             ; Gives respawns original "launcher" property
  lui a1,0x8000             ; Overwrite respawn property with "knockdown" (disables respawn combos)
  
  @@branch:
  j RespawnComboReturn      ; Return back to game.bin
  nop
*/
