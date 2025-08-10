.psx

  .org 0x800D4CB0 :: RevolutionNoHazardsReturn:
; 800D49EC RNG call, 1 in 512 chance of rotation every frame
; 800D4CA8 if no spin
; 800D49F4 if spin
; bne v0,r0,0x800D4CA8  orig instruction

; Spinny Spin logic
.org 0x800D49F4 :: RevoSpinReturn:
.org 0x800D4CA8 :: RevoNoSpinReturn:
.org 0x800D49EC
  j RevoFauxCeiling
  lui at,hi(HazardsVar)

; Spin cooldown adjuster
.org 0x800D4C9C :: RevoSpinCooldownReturn:
.org 0x800D4C90
  lui v0,hi(HazardsVar)
  j RevoSpinCooldown
  lbu v0,lo(HazardsVar)(v0)

; So that it's always 0 at the start of round
.org 0x800D45B4 :: ForceSpinCounterResetReturn:
.org 0x800D45AC
  j ForceSpinCounterReset

; 800D4B14 -> Freeze players
; 800D4C50 -> Unfreeze players
