.psx

RNG:
  ; Music RNG
  lui ra,hi(MusicRNGVar)
  lbu ra,lo(MusicRNGVar)(ra)
  sw v0,0x00a4(s0)  ; original instruction
  addi ra,ra,0x1    ; MusicRNG++
  slti v0,ra,16+6+NumberSongs   ; if(MusicRNG !< 0x10)
  bne v0,r0,@@CharacterRNG
  lui v0,hi(CharacterRNGVar)
  addi ra,ra,-10-6-NumberSongs  ; then(MusicRNG -= 10)
  
  @@CharacterRNG:
  lbu ra,lo(CharacterRNGVar)(v0) :: .resetdelay
  sb ra,lo(MusicRNGVar)(v0)
  addi ra,ra,0x1   ; CharacterRNG++
  slti v0,ra,0x18  ; if(CharacterRNG !< 0x18)
  bne v0,r0,@@StageRNG
  lui v0,hi(StageRNGVar)
  addi ra,ra,-24   ; then(CharacterRNG -= 0x18)
  
  @@StageRNG:
  lbu ra,lo(StageRNGVar)(v0) :: .resetdelay
  sb ra,lo(CharacterRNGVar)(v0)
  addi ra,ra,0x1   ; StageRNG++
  slti v0,ra,0x7   ; if(StageRNG !< 0x7)
  bne v0,r0,@@Return
  lui v0,hi(StageRNGVar)
  addi ra,ra,0x-7  ; then(CharacterRNG -= 7)
  
  @@Return:
  j RNGReturn
  sb ra,lo(StageRNGVar)(v0)



; arguments:
; t0 - RNG range of [0, X)
; t1 - base address for RNG history

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
