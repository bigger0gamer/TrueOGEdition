.psx

RecyclingTeleporter:
  lw v0,lo(PhysicsVar)(v0)
  nop
  beq v0,r0,@@Skip
  addi v0,r0,0x7FFF  ; Force Teleporter closed
  lw v0, 0x105c(s2)  ; Load actual Teleporter cooldown
  @@Skip:
  j 0x800D58C8
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

RecyclingPlatform:
  lw v1,lo(PhysicsVar)(v1)
  nop
  beq v1,r0,@@Skip
  lw v1, 0x0d68(s3)
  j RecyclingPlatformHazOnReturn
  nop  ; (not needed on mednafen or mister but I guess its needed to not hang on duckstation)
  @@Skip:
  j RecyclingPlatformHazOffReturn
  nop
