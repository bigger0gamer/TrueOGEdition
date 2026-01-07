; 
.psx

; No Lava Eruption
.org 0x800D46FC :: VolcanoNoEruptReturn:
.org 0x800D46F0
  lui v0,hi(GameplayVar)
  j VolcanoNoErupt
  lbu v0,lo(GameplayVar)(v0)

; Lava Fast Fall
.org 0x800D4984 :: VolcanoFastFallHazOnReturn:
.org 0x800d498c :: VolcanoFastFallHazOffReturn:
.org 0x800D4978
  subu v1,r0,v1
  j VolcanoFastFall
