.psx

  ; Random Character
  .org 0x800747BC :: RandomCharacterReturn:
  .org 0x800747B4
    j RandomCharacter
    lw v0,0x18(s2)  ; original instruction
  .org 0x800747D8  ; Makes Start (also) select character
    andi v0,s0,0x0840
  
  ; Random Stage
  .org 0x80079188 :: RandomStageReturn:
  .org 0x80079180
    j RandomStage
    andi t0,s5,0x0010
  
  ; Alt Colors
  .org 0x80074934 :: AltColorsCSSReturn:
  .org 0x80074924
    andi a0,s4,0x0108
    sltu a0,r0,a0
    j AltColorsCSS
    lui v0,0x8013
  .org 0x80074938
    andi v0,s4,0x0004
  
  ; Leave "Character Preview" In Arcade Mode
  .org 0x80075F10 :: ArcadeTriangleSaveReturn:
  .org 0x80075F14 :: ArcadeTriangleNoSaveReturn:
  .org 0x80075F04
    andi ra,v0,0x0010
    j ArcadeTriangle
    andi v0,v0,0x0040
