; 
.psx

; No Lava Eruption
.org 0x800D46FC :: VolcanoNoEruptReturn:
.org 0x800D46F0
  lui v0,hi(HazardsVar)
  j VolcanoNoErupt
  lbu v0,lo(HazardsVar)(v0)

; Lava Fast Fall
.org 0x800D4984 :: VolcanoFastFallHazOnReturn:
.org 0x800d498c :: VolcanoFastFallHazOffReturn:
.org 0x800D4978
  subu v1,r0,v1
  j VolcanoFastFall

; Set Stage ID + Walls
.org 0x800D4524 :: VolcanoWallsStageIDReturn:
.org 0x800D451C
  j VolcanoWallsStageID
  lui at,hi(HazardsVar)

; Raise Respawn
.org 0x800D4ABC :: VolcanoRaiseRespawnReturn:
.org 0x800D4AB4
  j VolcanoRaiseRespawn
  lui v0,hi(HazardsVar)
  slt v0,v0,at
