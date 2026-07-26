.psx

; 0 = No Ice (True OG)
; 1 = No Ice (Legacy)
; 2 = Normal
; 3 = All Ice
; 4 = Ice Skates

Physics:
  lbu v1,lo(PhysicsVar)(v1)
  addi v0,r0,2
  beq v1,v0,@@NormalPhysics
  lui v0,0x800D       ; original instruction
  addi v1,v1,-1
  beq v1,r0,@@NoIcePhysicsLegacy
  addiu v0,v0,0x35F8  ; original instruction
  addi v1,v1,1
  beq v1,r0,@@NoIceTrueOG
  addi v1,v1,-3
  bne v1,r0,@@IceSkates
  nop
  j AdjustedPhysicsReturn
  addi a1,r0,4        ; All Ice, just force stage ID of 4 (glacier) and skip back to after stage ID
  
  @@NormalPhysics:
  j NormalPhysicsReturn
  ; No need to have the orignal instruction twice when they'd be next to each other anyways!
  
  @@NoIcePhysicsLegacy:
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
  
  @@NoIceTrueOG:
  lui v1,0x8006       ; original instruction
  lw at,0xF8B8(v1)    ; load actual stage ID
  nop
  slti a2,at,4        ; stages 0-3 are unadjusted anyways, 4-6 will all match wild (1)
  bne a2,r0,@@DontForceWild2
  add a1,at,r0
  addi a2,r0,4
  beq a2,at,@@DontForceWild2
  addi a1,r0,6
  addi a2,r0,5
  beq a2,at,@@DontForceWild2
  addi a1,r0,5
  addi a1,r0,2
  
  @@DontForceWild2:
  j AdjustedPhysicsReturn
  nop
  
  @@IceSkates:
  j AdjustedPhysicsReturn
  addi a1,r0,6        ; All Ice, just force stage ID of 4 (glacier) and skip back to after stage ID
