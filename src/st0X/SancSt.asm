.psx

; No Lighting
.org 0x800D4768 :: SanctuaryHazOnReturn:
.org 0x800D4774 :: SanctuaryHazOffReturn:
.org 0x800D4760
  j SanctuaryNoHazards
  lui v0,hi(HazardsVar)

; Night Sanc
.org 0x800D4274 :: NightSanctuaryReturn:
.org 0x800D426C
  j NightSanctuary
  addiu a0,r0,0x0034  ; orig instruction?
