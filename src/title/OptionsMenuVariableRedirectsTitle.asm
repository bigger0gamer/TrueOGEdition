.psx

; Game Level -> Gameplay
;   GameplayVar
; Sound      -> Items
;   ItemsVar
; Autosave   -> Respawns
;   RespawnVar
; Vibration  -> Music
;   MusicVar

; Game Level
; Update Load Address
.org 0x8006BAD8 :: lui v0,hi(HazardsVar)
.org 0x8006BAE0 :: lbu v1,lo(HazardsVar)(v0)
; Update Save Address
.org 0x8006BB90 :: lui v1,hi(HazardsVar)
.org 0x8006BB94 :: j OptionsMenuGameplayVar
.org 0x8006BB98 :: sb  a0,lo(HazardsVar)(v1)

; Sound
; Update Load Address
.org 0x8006BAEC :: lui v0,hi(ItemsVar)
.org 0x8006BAF4 :: lbu v1,lo(ItemsVar)(v0)
; Update Save Address
.org 0x8006BBA8 :: lui a0,hi(ItemsVar)
.org 0x8006BBB8 :: sb  v1,lo(ItemsVar)(a0)

; Autosave
; Update Load Address
.org 0x8006BB14 :: lui v0,hi(RespawnVar)
.org 0x8006BB18 :: lbu v1,lo(RespawnVar)(v0)
; Update Save Address
.org 0x8006BBE8 :: lui a0,hi(RespawnVar)
.org 0x8006BBF4 :: sb  v1,lo(RespawnVar)(a0)
; Change texture pointer table to use Sound textures
.org 0x80064E44 :: .byte 0x44
.org 0x80064E48 :: .byte 0x50

; Vibration
; Update Load Address (See below)
.org 0x8006BB24 :: lui v0,hi(MusicVar)
.org 0x8006BB28 :: lbu v1,lo(MusicVar)(v0)
; Update Save Address
.org 0x8006BC04 :: lui a0,hi(MusicVar)
.org 0x8006BC0C :: sb  v1,lo(MusicVar)(a0)
; Invert "On"/"Off" texture for autosave and vibration (Options Menu Init)
.org 0x8006BB30
  nop
