.psx

; Dumps stuff into stack
InvisibleWallsStackPrep:
  ; run this during load delay while jaling: addi sp,sp,-0x18
  sw at,0x0(sp)
  sw a0,0x4(sp)
  sw a1,0x8(sp)
  sw t0,0xC(sp)
  sw t1,0x10(sp)
  jr ra
  sw t2,0x14(sp)



; at - must be free
; a0 - PlayerStatePointer
;      - 0x388 offset for Y position
;      - 0x384 offset for X position
; a1 - mode
;      - 0: Walls exist only above ceiling
;      - 1: Ceiling Only
;      - 2: Ceiling and Walls
; t0 - Ceiling
; t1 - Left Wall
; t2 - Right Wall
InvisibleWalls:
  ;nop               ; wait for lw to finish
  beq a0,r0,@@Skip  ; if pointer doesn't exist yet, skip for now
  addi a0,a0,0x384
  
  
  ; Ceiling!
  lw at,4(a0)       ; load player Y position
  nop
  
  ; Recycling Check - walls only exist above the "ceiling" (ceiling not enforced)
  bne a1,r0,@@HardCeiling
  slt at,at,t0      ; 0 if below ceiling, 1 if above
  beq at,r0,@@Skip  ; If below "ceiling", no walls, end func
  nop
  j @@Walls         ; Otherwise run walls
  addi a1,a1,-1      ; we don't care about mode 0 anymore, only 1 and 2 (easier beq comp)
  
  ; Now for the normal ceiling every other stage uses
  @@HardCeiling:
  beq at,r0,@@Walls  ; If above ceiling, bring 'em back down!
  addi a1,a1,-1      ; we don't care about mode 0 anymore, only 1 and 2 (easier beq comp)
  sw t0,4(a0)
  
  
  ; Walls!
  @@Walls:
  beq a1,r0,@@Skip   ; Skip if Ceiling only mode
  nop
  
  ; Left Wall
  lw at,0(a0)        ; load player X position
  nop
  slt a1,at,t1       ; We no longer care about mode, reuse for comparision
  beq a1,r0,@@RightWall
  nop
  sw t1,0(a0)
  
  @@RightWall:
  slt a1,at,t2       ; result is inverted this time!
  bne a1,r0,@@Skip
  nop
  sw t2,0(a0)
  
  @@Skip:
  jr ra
  nop



; Dumps stack back into registers
InvisibleWallsStackUnprep:
  ; run this during load delay while jaling: addi sp,sp,0x18
  lw a0,-0x14(sp)
  lw a1,-0x10(sp)
  lw t0,-0xC(sp)
  lw t1,-0x8(sp)
  lw t2,-0x4(sp)
  jr ra
  lw ra,-0x18(sp)
