.psx

GlacierPlatform:
  lui s3,hi(HazardsVar)
  lbu s3,lo(HazardsVar)(s3)
  nop
  addi s3,s3,-2
  beq s3,r0,@@Skip
  addi s3,s3,1
  beq s3,r0,@@HoldUpPlat
  nop
  
  addi at,ra,0
  jal InvisibleWallsStackPrep
  addi sp,sp,-0x18
  lui a0,hi(Player1StatePointer)
  lw a0,lo(Player1StatePointer)(a0)
  li t0,0xFFED0000
  li t1,0xFFF80000
  li t2,0x00080000
  jal InvisibleWalls
  addi a1,r0,2
  lui a0,hi(Player2StatePointer)
  lw a0,lo(Player2StatePointer)(a0)
  jal InvisibleWalls
  addi a1,r0,2
  jal InvisibleWallsStackUnprep
  addi sp,sp,0x18
  
  @@HoldUpPlat:
  j GlacierPlatformReturn
  addi s3,r0,0x1000
  @@Skip:
  lh s3,0x1ffc(v0)
  j GlacierPlatformReturn
  ; nop (reused from below)

GlacierFastFall:
  nop
  addi v0,v0,-2
  beq v0,r0,@@Skip
  addi v0,r0,1
  addi v0,r0,0x2
  @@Skip:
  j GlacierFastFallReturn
  nop

GlacierNoIciclesInitialize:
  lui at,hi(StageIDVar)
  addi v0,r0,5
  sb v0,lo(StageIDVar)(at)
  lbu v0,lo(HazardsVar)(at)
  j GlacierNoIciclesInitializeReturn
  srl v0,v0,1

GlacierNoIciclesLoop:
  j GlacierNoIciclesLoopReturn
  sw v0,0x0000(v1)  ; orig instruction

GlacierNoPlatDrop:
  lw t7,0x0388(s1)
  li t6,0xFFF80000
  slt t7,t7,t6
  bne t7,r0,@@GlacierCanDrop
  nop
  j PlatDropDenied
  nop
  @@GlacierCanDrop:
  j PlatDropApproved
  nop

GlacierRaiseRespawn:
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  lw v0,0x0350(a0)  ; orig instruction
  bne at,r0,@@Skip
  addiu v0,v0,0x1000  ; orig instruction
  addi v0,r0,0xFA00
  @@Skip:
  lw v1,0x0004(a1)  ; orig instruction
  jr ra
  slt v0,v0,v1
