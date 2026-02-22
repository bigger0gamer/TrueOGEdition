.psx

RecyclingTeleporter:
  lbu v0,lo(HazardsVar)(v0)
  nop
  addi v0,v0,-2
  bne v0,r0,@@Skip
  addi v0,r0,0x7FFF  ; Force Teleporter closed
  lw v0, 0x105c(s2)  ; Load actual Teleporter cooldown
  @@Skip:
  j 0x800D58C8
  nop

RecyclingPlatform:
  lbu v1,lo(HazardsVar)(v1)
  nop
  addi v1,v1,-2
  bne v1,r0,@@Skip
  lw v1, 0x0d68(s3)
  j RecyclingPlatformHazOnReturn
  nop  ; (not needed on mednafen or mister but I guess its needed to not hang on duckstation)
  @@Skip:
  j RecyclingPlatformHazOffReturn
  nop

RecyclingArm:
  lui a0,hi(HazardsVar)
  lbu a0,lo(HazardsVar)(a0)
  nop
  addi a0,a0,-1
  bne a0,r0,@@Skip
  nop
  sw r0,0x0D38(s0)
  @@Skip:
  j RecyclingArmReturn
  addu a0,s0,r0  ; orig instruction

RecyclingArmGrabAir:
  lbu v0,lo(HazardsVar)(v0)
  nop
  beq v0,r0,@@SkipCrate
  addiu a0,r0,0
  addiu a0,r0,1
  
  @@SkipCrate:
  lhu v0,0x0f04(s1)  ; original instruction
  j RecyclingArmGrabAirReturn
  nop

RecyclingCrateCounter:
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  addi at,at,-2
  beq at,r0,@@SkipEarlyReset
  slti at,v0,4
  bne at,r0,@@SkipEarlyReset
  nop
  lui v0,0
  
  @@SkipEarlyReset:
  j RecyclingCrateCounterReturn
  nop

RecyclingConveyers:
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  slti at,at,1
  j RecyclingConveyersReturn
  sw at,0x0EFC(s0)

RecyclingArmProperties:
  lbu at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@Blockable
  lui a1,0x8000
  lui at,hi(RecyclingArmHeight)
  addi a1,r0,0xf490
  sw a1,lo(RecyclingArmHeight)(at)
  lui a1,0x9800
  addi a1,a1,0x3FFF
  
  @@Blockable:
  j RecyclingArmPropertiesReturn
  addu a0,s3,r0  ; original instruction

RecyclingNoArmDelay:
  lui at,hi(HazardsVar)
  lbu at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@HazardsOn
  nop
  lui a1,0
  @@HazardsOn:
  j RecyclingNoArmDelayReturn
  nop
