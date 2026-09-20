.psx
; arguments:
; t0 - RNG range of [0, X)
; t1 - base address for RNG history
; t7 - length of history in bytes

; returns:
; v0 - random number

; needs free:
; a0 - argument to real RNG func, some sort of base address. "RNGPointer"
; t3 - current address for byte of history
; t4 - current offset from base
; t5 - current byte of history
; t6 - number of retries
; ra - duh
; at - keeps ra safe here while calls RNG func
OldRNG:
  ; method prep
  add at,ra,r0
  addi t6,r0,10+1
  
  ; call RNG func
  @@Retry:
  subi t6,t6,1
  beq t6,r0,@@NoMoreRetries
  lui a0,hi(RNGPointer)
  jal RNGFunc
  addi a0,a0,lo(RNGPointer)
  
  ; RNG % range = canidate
  divu v0,t0
  mfhi v0
  
  ; check history
  add t4,r0,r0
  add t3,t1,r0
  @@HistoryLoop:
  lbu t5,0(t3)
  addi t4,t4,1
  beq v0,t5,@@Retry
  addi t3,t3,1
  bne t4,t7,@@HistoryLoop
  nop
  
  ; save to history, return
  @@NoMoreRetries:
  add t3,t1,t7
  addi t4,t7,-1
  @@UpdateLoop:
  addi t3,t3,-1
  lbu t5,-1(t3)
  addi t4,t4,-1
  sb t5,0(t3)
  bne t4,r0,@@UpdateLoop
  nop
  jr at
  sb v0,-1(t3)


; arguments:
; t0 - RNG range of [0, X)
; t1 - base address for RNG history
; t7 - length of history in bytes

; returns:
; v0 - random number

; needs free:
; a0 - must be free
; t3 - current address for byte of history
; t4 - current offset from base
; t5 - current byte of history
; t6 - number of retries (must be free)
; ra - duh
; at - must be free
RNG:
  addi t6,r0,10+1
  
  ; call RNG func
  @@Retry:
  subi t6,t6,1
  beq t6,r0,@@NoMoreRetries
  
  ; Custom RNG!
  lui at,hi(RNGSeed)
  lw v0,lo(RNGSeed)(at)
  li a0,0x41C64E6D
  bne v0,r0,@@DontInitialize
  nop
  lui at,0x8006
  lw v0,0x2198(at)
  lui at,hi(RNGSeed)
  @@DontInitialize:
  mult v0,a0
  mflo v0
  addi v0,v0,0x3039
  sw v0,lo(RNGSeed)(at)
  
  
  ; RNG % range = canidate
  divu v0,t0
  mfhi v0
  
  ; check history
  add t4,r0,r0
  add t3,t1,r0
  @@HistoryLoop:
  lbu t5,0(t3)
  addi t4,t4,1
  beq v0,t5,@@Retry
  addi t3,t3,1
  bne t4,t7,@@HistoryLoop
  nop
  
  ; save to history, return
  @@NoMoreRetries:
  add t3,t1,t7
  addi t4,t7,-1
  @@UpdateLoop:
  addi t3,t3,-1
  lbu t5,-1(t3)
  addi t4,t4,-1
  sb t5,0(t3)
  bne t4,r0,@@UpdateLoop
  nop
  jr ra
  sb v0,-1(t3)
