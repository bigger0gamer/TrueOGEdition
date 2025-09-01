.psx

; Only 2P VS
.org 0x8002CAE4 :: Versus2PLockdownReturn:
.org 0x8002CADC
  j Versus2PLockdown
  lui at,hi(TOLockdown)



; Hold Start for 2 Seconds to Pause
.org 0x8001E554 :: PauseLockdownReturn:
.org 0x8001E54C
  j PauseLockdown
  lui at,hi(TOLockdown)
