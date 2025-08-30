.psx

; No Spinny spins
.org 0x800D4CB0 :: RevolutionNoHazardsReturn:
.org 0x800D4CA8
  j RevolutionNoHazards
  lui v0,hi(HazardsVar)

; reset custom var to 0
.org 0x800D45B4 :: ForceSpinCounterResetReturn:
.org 0x800D45AC
  j RevoStartRoundVarsReset

; Force Respawn
.org 0x800D4DAC :: RevoForceRespawnReturn:
.org 0x800D4DA4
  j RevoForceRespawn
  lui at,hi(HazardsVar)
