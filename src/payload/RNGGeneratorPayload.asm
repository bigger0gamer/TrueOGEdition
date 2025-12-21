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
RNG:
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
  
  
  ; check history
  ;lw t3,0(t1)
  ;addi t4,r0,4
  ;@@HistoryLoop:
  ;subi t4,t4,1
  ;andi t5,t3,0xFF
  ;srl t3,t3,8
  ;beq v0,t5,@@Retry
  ;nop
  ;bne t4,r0,@@HistoryLoop
  ;nop
 ; 
 ; ; save to history, return
 ; @@NoMoreRetries:
 ; lw t3,0(t1)
 ; nop
 ; sll t3,t3,8
 ; or t3,t3,v0
 ; jr at
 ; sw t3,0(t1)
