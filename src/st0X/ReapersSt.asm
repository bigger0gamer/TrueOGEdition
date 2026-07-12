.psx

; Black Void (Round 1)
; Left here for convinience
;.org 0x800D46E0
;  addi a1,r0,0

; No blur (Rounds 2+)
.org 0x800D4A7C
  addi a2,r0,0
  addi a3,r0,0

; No blur (Round 1)
.org 0x800D48C8
  addi a2,r0,0
  addi a3,r0,0xFF



; Always Round 1 visuals (True OG)
.org 0x800D40AC :: ReapersRoundOneReturn:
.org 0x800D40A4
  j ReapersRoundOne

; Visuals fixed at center + custom walls (True OG)
.org 0x800D4598 :: ReapersNoMoveOrbReturn:
.org 0x800D4590
  j ReapersNoMoveOrb

; Stop fucking my wall code D: (True OG)
; This is the code for max distance / normal walls
.org 0x800D45DC
  jal ReapersWallSelector
.org 0x800D45E8
  jal ReapersWallSelector

; Make orb approximate stage size (True OG)
.org 0x800D4354
  jal ReapersOrbSize
