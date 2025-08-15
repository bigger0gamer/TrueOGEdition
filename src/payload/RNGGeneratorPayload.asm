.psx
; arguments:
; t0 - RNG range of [0, X)
; t1 - base address for RNG history
; t7 - can be used to keep ra safe before calling this method

; returns:
; v0 - random number

; needs free:
; a0 - argument to real RNG func, some sort of base address. "RNGPointer"
; t3 - full history
; t4 - bytes left in history
; t5 - current byte of history
; t6 - number of retries
; ra - duh
; at - keeps ra safe here while calls RNG func
NewRNG:
  ; method prep
  add at,ra,r0
  addi t6,r0,5
  
  ; call RNG func
  @@Retry:
  subi t6,t6,1
  beq t6,r0,@@NoMoreRetries
  nop
  lui a0,hi(RNGPointer)
  jal RNGFunc
  addi a0,a0,lo(RNGPointer)
  
  ; RNG % range = canidate
  divu v0,t0
  mfhi v0
  
  ; check history
  lw t3,0(t1)
  addi t4,r0,4
  @@HistoryLoop:
  subi t4,t4,1
  andi t5,t3,0xFF
  srl t3,t3,8
  beq v0,t5,@@Retry
  nop
  bne t4,r0,@@HistoryLoop
  nop
  
  ; save to history, return
  @@NoMoreRetries:
  lw t3,0(t1)
  nop
  sll t3,t3,8
  or t3,t3,v0
  jr at
  sw t3,0(t1)
