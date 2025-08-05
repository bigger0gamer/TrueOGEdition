.psx

;     - 0x8006759C - prevent entering anything but 2P VS
;       a0 = 801CED84 -> Entering 2P VS  



; Character Bans
; We just don't save w/e BS the game does to figure out unlocked characters
; This will make them always 0, so we'll invert that meaning later
.org 0x800743E8
  nop
.org 0x80074404
  nop

; Normally, 0 = locked, 1 = unlocked
; Since RAM starts at 0, and we want unlocked by default, lets invert this!
.org 0x800780CF
  .byte 0x10  ; Controls small icon
.org 0x800782C3
  .byte 0x10  ; Controls big portriat P1
.org 0x80078307
  .byte 0x10  ; Controls big portriat P2
.org 0x8007490B
  .byte 0x12    ; Controls if can be picked
  slti s0,s0,1  ; Needs to be uninverted for func to work correctly



; something something :bs: to ban
;.org 0x800



; Locked Handicap

