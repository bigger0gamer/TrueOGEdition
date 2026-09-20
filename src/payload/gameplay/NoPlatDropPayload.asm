.psx

; s1 = player pointer
NoPlatDrop:
  ; Can always platdrop
  lbu t7,lo(GameplayFlagsVar)(at)
  nop
  andi t7,t7,100b
  bne t7,r0,@@Skip
  
  ; If not True OG Hazards, normal platdropping
  lbu t7,lo(HazardsVar)(at)
  nop
  bne t7,r0,@@NotTrueOG
  lbu t7,lo(StageIDVar)(at)
  
  ; Glacier (True OG)
  addi at,r0,5
  beq t7,at,GlacierNoPlatDrop
  addi at,at,1
  
  ; Volcano (True OG) - Forces Always Platdrop
  beq t7,at,@@Skip
  nop
  j @@NotTrueOG
  nop
  
  @@Skip:
  j PlatDropApproved
  nop
  @@DenyPlatDrop:
  j PlatDropDenied
  nop
  
  @@NotTrueOG:
  beq v0,r0,@@DenyPlatDrop
  nop
  j @@Skip
  nop

StageIDResetOnQuit:
  lui at,hi(StageIDVar)
  j StageIDResetOnQuitReturn
  sb r0,lo(StageIDVar)(at)
