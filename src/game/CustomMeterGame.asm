.psx

; GameplayFlagsVar
; Bit 0:
;   0 - Start game with empty meter
;   1 - Start game with full meter
; Bit 1:
;   0 - Meter carries into next round
;   1 - Meter doesn't carry into next round

.org 0x8007F1F4 :: CustomMeterStartingReturn:
.org 0x8007F1EC
  j CustomMeterStarting
  lui at,hi(GameplayFlagsVar)

.org 0x8007F4D4 :: CustomMeterCarryReturn:
.org 0x8006FD30
  jal CustomMeterCarry
