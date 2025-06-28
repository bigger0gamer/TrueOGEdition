; Character State Visualizer (title.bin)
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

.org 0x800789F8 :: CharacterStateVisualizerAbort:
.org 0x80078A18 :: CharacterStateVisualizerReturn:
.org 0x800789F0
  j CharacterStateVisualizer
  lw v0,0x0498(s3)  ; load player invicibility
