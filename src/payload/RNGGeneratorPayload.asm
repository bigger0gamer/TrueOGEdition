.psx

RNG:
  ; Music RNG
  lui ra,hi(MusicRNGVar)
  lbu ra,lo(MusicRNGVar)(ra)
  sw v0,0x00a4(s0)  ; original instruction
  addi ra,ra,0x1    ; MusicRNG++
  slti v0,ra,16+6+NumberSongs   ; if(MusicRNG !< 0x10)
  bne v0,r0,@@CharacterRNG
  lui v0,hi(CharacterRNGVar)
  addi ra,ra,-10-6-NumberSongs  ; then(MusicRNG -= 10)
  
  @@CharacterRNG:
  lbu ra,lo(CharacterRNGVar)(v0) :: .resetdelay
  sb ra,lo(MusicRNGVar)(v0)
  addi ra,ra,0x1   ; CharacterRNG++
  slti v0,ra,0x18  ; if(CharacterRNG !< 0x18)
  bne v0,r0,@@StageRNG
  lui v0,hi(StageRNGVar)
  addi ra,ra,-24   ; then(CharacterRNG -= 0x18)
  
  @@StageRNG:
  lbu ra,lo(StageRNGVar)(v0) :: .resetdelay
  sb ra,lo(CharacterRNGVar)(v0)
  addi ra,ra,0x1   ; StageRNG++
  slti v0,ra,0x7   ; if(StageRNG !< 0x7)
  bne v0,r0,@@Return
  lui v0,hi(StageRNGVar)
  addi ra,ra,0x-7  ; then(CharacterRNG -= 7)
  
  @@Return:
  j RNGReturn
  sb ra,lo(StageRNGVar)(v0)
