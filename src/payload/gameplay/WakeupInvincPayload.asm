.psx

; 0 - 4f
; 1 - 8f
; 2 - 0f, meant for replacement with cheat

WakeupInvinc:
  lui at,hi(WakeUpVar)
  lb at,lo(WakeupVar)(at)
  
  ; 0 - 4f
  nop
  beq at,r0,@@Return
  addiu v0,r0,4
  
  ; 1 - 8f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,8
  
  ; 2 - 0f
  addiu v0,r0,0
  
  
  @@Return:
  j WakeupInvincReturn
  nop
