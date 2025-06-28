; Wilderness - st01.bin
.psx

; No Rocks
.org 0x800D59C0 :: WildernessNoHazardsReturn:
.org 0x800D59B8
  j WildernessNoHazards
  lh v1, 0x0f7e(s1)  ; orig instruction?
