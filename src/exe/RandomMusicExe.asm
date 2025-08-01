.psx

; Random Music
.org 0x8001D720 :: RandomMusicReturn:  ; 2P VS Music
.org 0x8001D704 :: ArcadeMusicReturn:  ; 1P Mode Music
.org 0x8001D6FC
  j RandomMusic
  lw v0,0x02b0(t1)
