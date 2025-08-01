.psx

RandomCharacter:
  andi t0,s0,0x0800
  beq t0,r0,@@Skip
  lui t0,hi(CharacterRNGVar)
  lw v0,lo(CharacterRNGVar)(t0)
  @@Skip:
  j RandomCharacterReturn
  sw v0,0x0018(s2)


RandomStage:
  bne t0,r0,StageSelectToMainMenu
  andi v0,v0,0x0008  ; original instruction
  bne v0,r0,@@Skip
  andi t0,s5,0x0800
  beq t0,r0,@@Skip
  lui t0,hi(StageRNGVar)
  lw t0,lo(StageRNGVar)(t0)
  sw r0,0x00a8(s1)
  sw t0,0x01ac(s1)
  @@Skip:
  j RandomStageReturn
  nop


RandomMusic:
  lui v1,hi(MusicRNGVar)
  lw v1,lo(MusicRNGVar)(v1)
  beq v0,r0,@@ArcadeMusic
  slti v0,v1,0xA
  beq v0,r0,@@NoArcadeMusic
  addi v0,r0,6
  beq v0,v1,@@NoArcadeMusic
  nop
  @@ArcadeMusic:
  j ArcadeMusicReturn
  add v0,r0,r0
  @@NoArcadeMusic:
  slti v0,v1,16
  bne v0,r0,@@NotCustom
  nop
  addi v1,v1,0x69  ; nice :D
  @@NotCustom:
  j RandomMusicReturn
  addi t0,v1,0x0


AltColorsCSS:
  addi v0,v0,0xAA50
  slt v0,v0,s2
  beq v0,r0,@@Skip
  lui v0,hi(Color1PVar)
  j AltColorsCSSReturn
  sw a0,lo(Color2PVar)(v0)
  @@Skip:
  j AltColorsCSSReturn
  sw a0,lo(Color1PVar)(v0)

AltColorsSSS:
  lw v1,lo(Color1PVar)(a0)
  nop
  sw v1,0x0318(v0)
  lw v1,lo(Color2PVar)(a0)
  jr ra
  sw v1, 0x0330(v0)


StageSelectToMainMenu:
  addi t0,r0,9
  sw t0,0x008C(s1)
  j RandomStageReturn
  sw t0,0x0088(s1)

ArcadeTriangle:
  beq ra,r0,@@NoTriangle
  nop
  addi v0,r0,9
  j ArcadeTriangleSaveReturn
  sw v0,0x008C(s0)
  
  @@NoTriangle:
  beq v0,r0,@@NoSave
  addiu v0,r0,0x0008
  j ArcadeTriangleSaveReturn
  nop
  @@NoSave:
  j ArcadeTriangleNoSaveReturn
  nop
