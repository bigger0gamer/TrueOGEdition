.psx

; Random Music
.org 0x8001D720 :: RandomMusicReturn:  ; 2P VS Music
.org 0x8001D704 :: ArcadeMusicReturn:  ; 1P Mode Music
.org 0x8001D6FC
  j RandomMusic
  lui v1,hi(MusicRNGVar)
