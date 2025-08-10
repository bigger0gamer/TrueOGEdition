.psx

; Game Level -> Physics
;   PhysicsVar
; Sound      -> Hazards
;   HazardsVar
; Autosave   -> Items
;   ItemsVar
; Vibration  -> Respawn Combos
;   RespawnVar

; Game Level
; Update Load Address
.org 0x8006BAD8 :: lui v0,hi(PhysicsVar)
.org 0x8006BAE0 :: lbu v1,lo(PhysicsVar)(v0)
; Update Save Address
.org 0x8006BB90 :: lui v1,hi(PhysicsVar)
.org 0x8006BB98 :: sb  a0,lo(PhysicsVar)(v1)

; Sound
; Update Load Address
.org 0x8006BAEC :: lui v0,hi(HazardsVar)
.org 0x8006BAF4 :: lbu v1,lo(HazardsVar)(v0)
; Update Save Address
.org 0x8006BBA8 :: lui a0,hi(HazardsVar)
.org 0x8006BBB8 :: sb  v1,lo(HazardsVar)(a0)

; Autosave
; Update Load Address
.org 0x8006BB14 :: lui v0,hi(ItemsVar)
.org 0x8006BB18 :: lbu v1,lo(ItemsVar)(v0)
; Update Save Address
.org 0x8006BBE8 :: lui a0,hi(ItemsVar)
.org 0x8006BBF4 :: sb  v1,lo(ItemsVar)(a0)

; Vibration
; Update Load Address
.org 0x8006BB24 :: lui v0,hi(RespawnVar)
.org 0x8006BB28 :: lbu v1,lo(RespawnVar)(v0)
; Update Save Address
.org 0x8006BC04 :: lui a0,hi(RespawnVar)
.org 0x8006BC0C :: sb  v1,lo(RespawnVar)(a0)


; Okay, so this one needs explanation. Autosave and Vibration both use the text "Yes" and "No".
; The devs naturally made both of them use the same texture. One problem however:
; I want the default state (0) of each say "Off" for Items but "On" for Respawn Combos.
; The game already inverts the state of each variable (0->1,1->0) to show the right texture,
; so I can just nop that instruction to invert it again. Except, it uses the same instruction
; for both variables, so I have to move the inverting instuction to somewhere only Items can reach.
; The instruction is only shared for options menu initalization.

; Invert "On"/"Off" texture for Items and Respawns (Options Menu Init)
; 0 Off -> 0 On
; 1 On     1 Off
.org 0x8006BB30
  nop

; Uninvert "On"/"Off" texture for Items (Options Menu Init)
.org 0x8006BB20
  sltiu v1,v1,0x0001

; Invert "On"/"Off" texture for Respawns (when changed)
.org 0x8006BC08
  nop
