.psx

; s1 = player pointer
NoPlatDrop:
  beq v0,r0,@@DenyPlatDrop
  lbu t7,lo(HazardsVar)(at)
  nop
  bne t7,r0,@@Skip
  lbu t7,lo(StageIDVar)(at)
  addi at,r0,5
  
  beq t7,at,GlacierNoPlatDrop
  addi at,at,1
  
  beq t7,at,@@DenyPlatDrop
  nop
  
  @@Skip:
  j PlatDropApproved
  nop
  @@DenyPlatDrop:
  j PlatDropDenied
  nop

StageIDResetOnQuit:
  lui at,hi(StageIDVar)
  j StageIDResetOnQuitReturn
  sb r0,lo(StageIDVar)(at)
