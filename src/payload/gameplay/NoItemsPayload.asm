.psx

; The game has a limit for how many items can be spawned on the stage at once: 3.
; Interestingly, this limit is hardcoded into the *stage code*, not the engine code.
; The stage always loads 3 into a2, which eventually gets shuffled to s2.
; We're gonna throw that away, and load our items variable.
; Since off happens to be 0, then we can just multiply ItemsVar by 3.
; Off = 0 x 3 = 0 items can be spawned on the stage at once
; On  = 1 x 3 = 3 items can be spawned on the stage at once

NoItems:
  lw s2,lo(ItemsVar)(s2)  ; load items var
  sw v1,0x0014(s3)        ; original instruction
  sll v0,s2,1             ; double items var -> v0
  add s2,s2,v0            ; items var + double items var = items var * 3
  j NoItemsReturn
  addiu v0,v0,0x005A      ; original instruction
