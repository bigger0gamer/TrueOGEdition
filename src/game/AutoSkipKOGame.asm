.psx

; Force skip on non-final round
.org 0x80071910 :: DoNotSkipKO:
.org 0x800718F4
  lw v0,0x02C8(s0)  ; orig instruction
  .skip 4
  andi at,v0,0x80
  bne at,r0,DoNotSkipKO

; Force win quote on final round
.org 0x80071DDC :: DidNotSkip:
.org 0x80071DCC :: DidSkip:
.org 0x80071DC0
  lw at,0x02C8(s3)
  j ForceWinQuote
  andi at,at,0x80
