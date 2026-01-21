.psx

; 0 - 8f
; 1 - 4f
; 2 - 2f
; 3 - 7f
; 4 - 6f
; 5 - 5f
; 6 - 3f
; 7 - 1f
; 8 - 0f

WakeupInvinc:
  lui at,hi(WakeUpVar)
  lb at,lo(WakeupVar)(at)
  
  ; 0 - 8f
  nop
  beq at,r0,@@Return
  addiu v0,r0,8
  
  ; 1 - 4f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,4
  
  ; 2 - 2f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,2
  
  ; 3 - 7f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,7
  
  ; 4 - 6f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,6
  
  ; 5 - 5f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,5
  
  ; 6 - 3f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,3
  
  ; 7 - 1f
  addi at,at,-1
  beq at,r0,@@Return
  addiu v0,r0,1
  
  ; 8 - 0f
  addiu v0,r0,0
  
  
  @@Return:
  j WakeupInvincReturn
  nop
