.psx

; Save Player State Pointers to RAM for later use in invisible walls (New No Haz)
.org 0x800706F0
  jal PlayerStatePointers
