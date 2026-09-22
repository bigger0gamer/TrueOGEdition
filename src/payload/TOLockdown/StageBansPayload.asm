.psx

; safe registers - at, a0, s0-5
; v0 - stage ID
; s0 - upper limit
; s1 - base address for load stage ID
; s2 - lower limit
; s3 s5 - player inputs
; s4 - ?

; sra?

StageBans:
  lui at,hi(NoHazCustomVar)
  lw at,lo(NoHazCustomVar)(at)
  addi a0,v0,0
  srl at,at,23
  @@Loop:
  srl at,at,1
  bne a0,r0,@@Loop
  addi a0,a0,-1
  andi at,at,1
  beq at,r0,@@NotBanned
  nop
  
  lui at,hi(SSSCrashTracker)
  lbu a0,lo(SSSCrashTracker)(at)
  nop
  addi a0,a0,1
  sb a0,lo(SSSCrashTracker)(at)
  slti at,a0,10
  bne at,r0,@@NoCrashYet
  slti at,a0,20
  
  addi s3,r0,0x2000
  addi s5,r0,0x2000
  bne at,r0,@@NoCrashYet
  nop
  
  lui at,hi(TOLockdown)
  sb r0,lo(TOLockdown)(at)
  sw r0,lo(CharacterStageBans)(at)
  sw r0,lo(NoHazCustomVar)(at)
  
  @@NoCrashYet:
  j StageBannedReturn
  nop
  @@NotBanned:
  lui at,hi(SSSCrashTracker)
  sb r0,lo(SSSCrashTracker)(at)
  beq t0,r0,@@BranchEqual
  lui a0,0x8006
  j StageBansNotEqualReturn
  nop
  @@BranchEqual:
  j StageBansEqualReturn
  nop
