; Garbage Recycling Center - st00.bin
.psx

; Disable Teleporter
.org 0x800D58C8 :: RecyclingTeleporterReturn:
.org 0x800D58C0
  j RecyclingTeleporter
  lui v0,hi(HazardsVar)

; Disable Arm
.org 0x800D4EF0 :: RecyclingArmReturn:
.org 0x800D4EE8
  j RecyclingArm
  sw a0,0x0D38(s0)  ; orig instruction?

; Freeze Moving Platforms
.org 0x800D70BC :: RecyclingPlatformHazOnReturn:
.org 0x800D70C0 :: RecyclingPlatformHazOffReturn:
.org 0x800D70B4
  j RecyclingPlatform
  lui v1,hi(PhysicsVar)
