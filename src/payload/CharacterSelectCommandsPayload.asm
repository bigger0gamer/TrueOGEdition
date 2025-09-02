.psx

RandomCharacter:
  lui at,hi(CSSModePointer)
  lw at,lo(CSSModePointer)(at)
  addi t0,r0,0x25
  bne at,t0,@@RandomCharacter
  addi t0,r0,0x002C
  and at,s4,t0
  bne at,t0,@@SkipEnableTOLockdown
  addi t0,r0,1
  lui at,hi(TOLockdown)
  sb t0,lo(TOLockdown)(at)
  lui t0,0x7FFF
  lui at,hi(Player1CursorFlash)
  sw t0,lo(Player1CursorFlash)(at)
  @@SkipEnableTOLockdown:
  andi t0,s0,0x0080
  beq t0,r0,@@RandomCharacter
  lui at,hi(CharacterTable)
  sll v0,v0,2
  add at,at,v0
  lw t0,lo(CharacterTable)(at)
  srl v0,v0,2
  slti t0,t0,1
  sw t0,lo(CharacterTable)(at)
  addi at,v0,0
  addi t0,r0,1
  @@Loop:
  sll t0,t0,1
  bne at,r0,@@Loop
  addi at,at,-1
  lui at,hi(CharacterStageBans)
  lw at,lo(CharacterStageBans)(at)
  srl t0,t0,1
  xor t0,t0,at
  lui at,hi(CharacterStageBans)
  sw t0,lo(CharacterStageBans)(at)
  
  @@RandomCharacter:
  andi t0,s0,0x0800
  beq t0,r0,@@Skip
  li t1,CharacterRNGHistory
  jal RNG
  addi t0,r0,24
  @@Skip:
  j RandomCharacterReturn
  sw v0,0x0018(s2)


RandomStage:
  bne t0,r0,StageSelectToMainMenu
  andi v0,v0,0x0008  ; original instruction
  bne v0,r0,@@Skip
  
  ; Random Music
  andi t0,s5,0x0040
  beq t0,r0,@@RandomStage
  lui at,hi(TOLockdown)
  lbu at,lo(TOLockdown)(at)
  addi t0,r0,10+6+NumberSongs
  beq at,r0,@@AllMusic
  addi s3,r0,0x0040
  lui at,hi(CSSModePointer)
  lw at,lo(CSSModePointer)(at)
  addi t0,r0,0x25
  beq at,t0,StageSelectToMainMenu
  addi t0,r0,10
  @@AllMusic:
  li t1,MusicRNGHistory
  jal RNG
  addi s5,r0,0x0040
  
  ; Random Stage
  @@RandomStage:
  andi t0,s5,0x0800
  beq t0,r0,@@StageStrikes
  li t1,StageRNGHistory
  addi s3,r0,0x0800
  addi s5,r0,0x0800
  jal RNG
  addi t0,r0,7
  sw r0,0x00a8(s1)
  sw v0,0x01ac(s1)
  lui v0,0
  
  ; Stage Strikes
  @@StageStrikes:
  andi t0,s5,0x0080
  beq t0,r0,@@StrikeToLegalStages
  lui at,hi(NoHazCustomVar)
  lw at,lo(NoHazCustomVar)(at)
  lw v0,0x01AC(s1)
  addi s3,r0,0x2000
  addi s5,r0,0x2000
  addi t0,r0,1
  sll t0,t0,23
  @@Loop:
  sll t0,t0,1
  bne v0,r0,@@Loop
  addi v0,v0,-1
  or at,at,t0
  lui v0,hi(NoHazCustomVar)
  sw at,lo(NoHazCustomVar)(v0)
  lui t0,0xFF00
  and at,at,t0
  bne at,t0,@@StrikeToLegalStages
  lui v0,0
  lui at,hi(CharacterStageBans)
  lw t0,lo(CharacterStageBans)(at)
  nop
  sw t0,lo(NoHazCustomVar)(at)
  
  ; Immediatly strike down to just Recycling, Sanc, Glacier
  @@StrikeToLegalStages:
  andi t0,s5,0x0020
  beq t0,r0,@@Skip
  lui at,hi(TOLockdown)
  lbu at,lo(TOLockdown)(at)
  lui t0,0xE600
  beq at,r0,@@Unlocked
  lui at,hi(NoHazCustomVar)
  lw t0,lo(CharacterStageBans)(at)
  nop
  @@Unlocked:
  sw t0,lo(NoHazCustomVar)(at)
  addi s3,r0,0x2000
  addi s5,r0,0x2000
  
  ; Return to game code
  @@Skip:
  j RandomStageReturn
  nop


RandomMusic:
  lui v1,hi(MusicRNGHistory)
  beq v0,r0,@@ArcadeMusic
  lbu v1,lo(MusicRNGHistory)(v1)
  nop
  addi v1,v1,6
  slti v0,v1,0xA
  beq v0,r0,@@NoArcadeMusic
  addi v0,r0,6
  beq v0,v1,@@NoArcadeMusic
  nop
  @@ArcadeMusic:
  addiu a0,r0,0xC
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
  lw at,lo(CharacterStageBans)(at)
  lui v0,hi(NoHazCustomVar)
  sw at,lo(NoHazCustomVar)(v0)
  lui v0,0x8013
  addi v0,v0,0xAA50
  slt v0,v0,s2
  beq v0,r0,@@Skip
  lui v0,hi(Color1PVar)
  j AltColorsCSSReturn
  sb a0,lo(Color2PVar)(v0)
  @@Skip:
  j AltColorsCSSReturn
  sb a0,lo(Color1PVar)(v0)

AltColorsSSS:
  lbu v1,lo(Color1PVar)(a0)
  nop
  sw v1,0x0318(v0)
  lbu v1,lo(Color2PVar)(a0)
  jr ra
  sw v1,0x0330(v0)


StageSelectToMainMenu:
  lui at,hi(TOLockdown)
  lbu at,lo(TOLockdown)(at)
  lui t0,hi(CSSModePointer)
  beq at,r0,@@Skip
  lw at,lo(CSSModePointer)(t0)
  addi t0,r0,0x25
  bne at,t0,@@Skip
  lui at,hi(NoHazCustomVar)
  lw t0,lo(NoHazCustomVar)(at)
  nop
  sw t0,lo(CharacterStageBans)(at)
  @@Skip:
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
