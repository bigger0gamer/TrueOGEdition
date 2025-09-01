.psx

; s0 - p1 inputs
; a3 - p2 inputs
; 0x0800 = start
; free reg - v0, v1

PauseLockdown:
  lbu at,lo(TOLockdown)(at)
  and a0,v1,v0  ; orig instruction
  beq at,r0,@@Skip
  lui at,hi(NoHazCustomVar)
  lw at,lo(NoHazCustomVar)(at)
  andi s0,s0,0xF7FF
  andi a3,a3,0xF7FF
  andi v0,at,0xFFFF
  srl v1,at,16
  lui at,hi(Player1HeldInputs)
  lw t0,lo(Player1HeldInputs)(at)
  lw t1,lo(Player2HeldInputs)(at)
  
  ; Player 1
  andi at,t0,0x0800
  bne at,r0,@@HoldingPauseP1
  addi v0,v0,1
  lui v0,0
  @@HoldingPauseP1:
  slti at,v0,60
  bne at,r0,@@NotHeldLongEnoughP1
  nop
  ori s0,s0,0x0800
  lui v0,0
  @@NotHeldLongEnoughP1:
  
  ; Player 2
  andi at,t1,0x0800
  bne at,r0,@@HoldingPauseP2
  addi v1,v1,1
  lui v1,0
  @@HoldingPauseP2:
  slti at,v1,60
  bne at,r0,@@NotHeldLongEnoughP2
  nop
  ori a3,a3,0x0800
  lui v1,0
  @@NotHeldLongEnoughP2:
  
  sll v1,v1,16
  or at,v1,v0
  lui v1,hi(NoHazCustomVar)
  sw at,lo(NoHazCustomVar)(v1)
  
  @@Skip:
  andi v1,s0,0x0800
  beq v1,r0,@@NotPlayer1Pause
  addi v1,r0,0x31
  lui at,hi(PauseTextPointer)
  sb v1,lo(PauseTextPointer)(at)
  @@NotPlayer1Pause:
  andi v1,a3,0x0800
  beq v1,r0,@@NotPlayer2Pause
  addi v1,r0,0x32
  lui at,hi(PauseTextPointer)
  sb v1,lo(PauseTextPointer)(at)
  @@NotPlayer2Pause:
  
  j PauseLockdownReturn
  andi v1,s0,0x0800  ; orig instruction
