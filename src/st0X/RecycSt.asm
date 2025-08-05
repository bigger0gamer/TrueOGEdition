; Garbage Recycling Center - st00.bin
.psx

; Disable Teleporter
.org 0x800D58C8 :: RecyclingTeleporterReturn:
.org 0x800D58C0
  j RecyclingTeleporter
  lui v0,hi(HazardsVar)

; Freeze Moving Platforms
.org 0x800D70BC :: RecyclingPlatformHazOnReturn:
.org 0x800D70C0 :: RecyclingPlatformHazOffReturn:
.org 0x800D70B4
  j RecyclingPlatform
  lui v1,hi(HazardsVar)

; Disable Arm (LEGACY variant? No longer used)
.org 0x800D4EF0 :: RecyclingArmReturn:
.org 0x800D4EE8
;  j RecyclingArm
;  sw a0,0x0D38(s0)  ; orig instruction?



; 800D6268 800D62B0 800D64A4 nop
; 800DA0F4 lui a1,0x9800

; Make arm grab air (no crate)
.org 0x800D6240 :: RecyclingArmGrabAirReturn:
.org 0x800D6238
  j RecyclingArmGrabAir
  lui v0,hi(HazardsVar)

; Make stage never open
.org 0x800D62B0 :: RecyclingCrateCounterReturn:
.org 0x800D62A8
  j RecyclingCrateCounter

; Make arm attack unblockable
.org 0x800DA0F8 :: RecyclingArmUnblockableReturn:
.org 0x800DA0F0
  j RecyclingArmUnblockable
  lui at,hi(HazardsVar)

; conveyer belts always on
.org 0x800D3FE0 :: RecyclingConveyersReturn:
.org 0x800D3FD8
  j RecyclingConveyers
