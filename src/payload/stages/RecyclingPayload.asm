.psx

RecyclingTeleporter:
  lw v0,lo(HazardsVar)(v0)
  nop
  beq v0,r0,@@Skip
  addi v0,r0,0x7FFF  ; Force Teleporter closed
  lw v0, 0x105c(s2)  ; Load actual Teleporter cooldown
  @@Skip:
  j 0x800D58C8
  nop

RecyclingPlatform:
  lw v1,lo(HazardsVar)(v1)
  nop
  beq v1,r0,@@Skip
  lw v1, 0x0d68(s3)
  j RecyclingPlatformHazOnReturn
  nop  ; (not needed on mednafen or mister but I guess its needed to not hang on duckstation)
  @@Skip:
  j RecyclingPlatformHazOffReturn
  nop

RecyclingArm:
  lui a0,hi(HazardsVar)
  lw a0,lo(HazardsVar)(a0)
  nop
  bne a0,r0,@@Skip
  nop
  sw a0,0x0D38(s0)
  @@Skip:
  j RecyclingArmReturn
  addu a0,s0,r0

RecyclingArmGrabAir:
  lw v0,lo(HazardsVar)(v0)
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
  lw at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@SkipEarlyReset
  slti at,v0,4
  bne at,r0,@@SkipEarlyReset
  nop
  lui v0,0
  
  @@SkipEarlyReset:
  j RecyclingCrateCounterReturn
  nop

RecyclingConveyers:
  lui at,hi(HazardsVar)
  lw at,lo(HazardsVar)(at)
  nop
  slti at,at,1
  j RecyclingConveyersReturn
  sw at,0x0EFC(s0)

RecyclingArmUnblockable:
  lw at,lo(HazardsVar)(at)
  nop
  bne at,r0,@@Blockable
  lui a1,0x8000
  lui a1,0x9800
  
  @@Blockable:
  j RecyclingArmUnblockableReturn
  addu a0,s3,r0  ; original instruction
