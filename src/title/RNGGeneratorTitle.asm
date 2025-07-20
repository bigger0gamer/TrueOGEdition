.psx

; RNG Generator: We just hook a global frame counter, and use it to make "RNG" counters for
  ; stuff like random character, stage, or music
  .org 0x800752F8 :: RNGReturn:
  .org 0x800752F0
    j RNG
    addiu v0,v0,0x0001  ; original instruction
