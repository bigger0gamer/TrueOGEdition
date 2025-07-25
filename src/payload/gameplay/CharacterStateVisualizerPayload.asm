; Character State Visualizer (Payload)
.psx


; 0x800789F0 - loads hitstun flash

; 0x80078A18, 0x80078A24, 0x80078A30, 0x80078A3C - colorizer functions
; a0, s1 - player specific address
; a1, s0 - address to load color from
; s4 - preset color value (0x1000)

; free registers: at, v0, s1, s0, s4
; To custom call method:
; addiu s1,s3,0x0400 to set s1 for player address
; addu a0,s1,r0      to set a1 for player address
; li s0,CustomColor  to setup custom color
; add a1,s0,r0       to setup custom color
; j 0x80078A18       to start running color functions

; -GB = Cyan
; R-B = Purple
; RG- = Yellow
; "Off" 0x0200, "On" 0x0A00, "flash" subtract 0x0200

; load invinc - lw v0,0x0498(s3)

CharacterStateVisualizer:
  li at,0x80107744
  beq s3,at,@@NotPlayer2
  nop
  li at,Player2StatePointer
  sw s3,0x0000(at)
  @@NotPlayer2:
  
  lb v0,0x0492(s3)
  ; Yellow Flash--
  blez s1,@@SkipYellowFlashMinusMinus
  addi s1,s1,-1
  sb s1,0x0491(s3)
  
  @@SkipYellowFlashMinusMinus:
  beq v0,r0,@@SkipYellowFlash
  slt at,s1,r0
  bne at,r0,@@SkipYellowFlash
  andi at,s1,1
  sll at,at,11
  addi s4,at,0x0700
  addiu s1,s3,0x0400
  addu a0,s1,r0
  li s0,StateColor
  add a1,s0,r0
  sw s4,0x0000(s0)
  sw s4,0x0004(s0)
  j CharacterStateVisualizerReturn
  sw at,0x0008(s0)
  
  @@SkipYellowFlash:
  lw v0,0x0498(s3)  ; load player invicibility'
  nop
  beq v0,r0,@@NotInvincible  ; if not invincible, run original instructions
  andi at,v0,1
  sll at,at,10
  addi s4,at,0x0A00
  addiu s1,s3,0x0400
  addu a0,s1,r0
  li s0,StateColor
  add a1,s0,r0
  sw at,0x0000(s0)
  sw s4,0x0004(s0)
  j CharacterStateVisualizerReturn
  sw s4,0x0008(s0)
  
  @@NotInvincible:
  lb v0,0x0490(s3)  ; original instruction*
  j CharacterStateVisualizerAbort
  nop

; 0x0028(s2)  load cur stun
; lw ?,0x0220(s0) -> 0x0014(?) load stun limit
; nop
; slt ?,curStun,StunLimit
; xori ?,?,1
; free reg: at, a1
IsKnockdown:
  addi at,r0,0xA
  sb at,0x0491(s0)
  lui ra,hi(0x800817AC)
  j 0x8008198C
  addi ra,ra,lo(0x800817AC)

IsStun:
  jr ra
  sb v0,0x0492(a0)
