.psx

GlacierPlatform:
  lui s3,hi(HazardsVar)
  lbu s3,lo(HazardsVar)(s3)
  nop
  addi s3,s3,-2
  beq s3,r0,@@Skip
  addi s3,s3,1
  beq s3,r0,@@HoldUpPlat
  
  li s3,Player1StatePointer + 0x388
  lw t7,0(s3)
  li t6,0xFFED0000
  slt t7,t7,t6
  beq t7,r0,@@Player1LeftCheck
  nop
  sw t6,0(s3)
  @@Player1LeftCheck:
  addi s3,s3,-4
  lw t7,0(s3)
  li t5,0xFFF80000
  slt t3,t7,t5
  beq t3,r0,@@Player1RightCheck
  nop
  sw t5,0(s3)
  @@Player1RightCheck:
  li t4,0x00080000
  slt t3,t7,t4
  bne t3,r0,@@Player2HeightCheck
  nop
  sw t4,0(s3)
  
  @@Player2HeightCheck:
  li s3,Player2StatePointer
  lw s3,0(s3)
  nop
  beq s3,r0,@@HoldUpPlat
  nop
  addi s3,s3,0x388
  lw t7,0(s3)
  nop
  slt t7,t7,t6
  beq t7,r0,@@Player2LeftCheck
  nop
  sw t6,0(s3)
  @@Player2LeftCheck:
  addi s3,s3,-4
  lw t7,0(s3)
  nop
  slt t3,t7,t5
  beq t3,r0,@@Player2RightCheck
  nop
  sw t5,0(s3)
  @@Player2RightCheck:
  nop
  slt t3,t7,t4
  bne t3,r0,@@HoldUpPlat
  nop
  sw t4,0(s3)
  
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
