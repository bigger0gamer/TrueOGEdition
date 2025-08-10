.psx

; 0 = No Ice
; 1 = Normal
; 2 = All Ice

Physics:
  lbu v1,lo(PhysicsVar)(v1)
  addi v0,r0,1
  beq v1,v0,@@NormalPhysics
  lui v0,0x800D       ; original instruction
  beq v1,r0,@@NoIcePhysics
  addiu v0,v0,0x35F8  ; original instruction
  j AdjustedPhysicsReturn
  addi a1,r0,4        ; All Ice, just force stage ID of 4 (glacier) and skip back to after stage ID
  
  @@NormalPhysics:
  j NormalPhysicsReturn
  ; No need to have the orignal instruction twice when they'd be next to each other anyways!
  
  @@NoIcePhysics:
  lui v1,0x8006       ; original instruction
  lw a1,0xF8B8(v1)    ; load actual stage ID
  nop
  slti a2,a1,4        ; stages 0-3 are unadjusted anyways, 4-6 will all match wild (1)
  bne a2,r0,@@DontForceWild
  nop
  addi a1,r0,1
  @@DontForceWild:
  j AdjustedPhysicsReturn
  nop
