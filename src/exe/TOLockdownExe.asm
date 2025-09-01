.psx



; Only 2P VS
.org 0x8002CAE4 :: Versus2PLockdownReturn:
.org 0x8002CADC
  j Versus2PLockdown
  lui at,hi(TOLockdown)
