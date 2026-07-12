.psx

.org 0x80080E70 :: PlatDropDenied:
.org 0x80080E48 :: PlatDropApproved:
.org 0x80080E40
  j NoPlatDrop
  lui at,hi(HazardsVar)

; Reset StageIDVar on pause quit
.org 0x800720C0 :: StageIDResetOnQuitReturn:
.org 0x800720A8
  j StageIDResetOnQuit
