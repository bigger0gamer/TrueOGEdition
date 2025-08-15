; Digimon Rumble Arena: True OG Edition
; created by Yuri Bacon
; v2 Refactor
; For more information, check out the README.md
.psx



; SLUS_014.04, anything that needs to be inserted into the main executable or payload goes here
; The output file "TITLE_ID" should be replaced by build.sh with a sed command at build time (see build.sh for more info)
.openfile "../build env/Digimon Rumble Arena (USA)/SLUS_014.04","../build env/Digimon Rumble Arena (USA)/TITLE_ID",0x8000F800

  ; Inserts a version string into the main exe's header, to make identifying ROM revions easier
  ; (well, if you know what you're doing anyways lol)
  ; Like the title ID above, you should specify this string in build.sh
  .orga 0x90
    .ascii VERSION_STRING


  ; Custom Variable Labels
   ; Constants
   NumberSongs equ NUMBER_SONGS
   .org 0x80037010 :: RNGFunc:
   .org 0x8005EE48 :: RNGPointer:
   
   ; 1 byte vars
   .org 0x801FC8F0 :: PhysicsVar:
   .org 0x801FC8F1 :: ItemsVar:
   .org 0x801FC8F2 :: HazardsVar:
   .org 0x801FC8F3 :: RespawnVar:
   .org 0x801FC8F4 :: Color1PVar:
   .org 0x801FC8F5 :: Color2PVar:
   .org 0x801FC8F6 :: TOLockdown:
   
   ; 12 byte var
   .org 0x801FC900 :: StateColor:
   
   ; 4 byte vars
   .org 0x801FC90C :: CharacterStageBans:
   .org 0x801FC910 :: NoHazCustomVar:
   .org 0x801FC914 :: Player2StatePointer:
   .org 0x801FC918 :: CharacterRNGHistory:
   .org 0x801FC91C :: StageRNGHistory:
   .org 0x801FC920 :: MusicRNGHistory:
  
  
  ; First, we need to start with any data that needs to be modified in SLUS_014.04 itself
  .include "exe/EverythingUnlockedExe.asm"
  .include "exe/RandomMusicExe.asm"
  .include "exe/AltColorExe.asm"
  
  
  ; As most of the game's code can't be resized,
  ; anything that needs extra data has to be stored somewhere else, in unused RAM.
  ; It's stored in empty space at the end of the exe, and this code moves that "payload".
  ; From now, until we close this file, we cannot use .org anymore, so we need to make
  ; any labels for variables and such *before* this point (or where we have another file open)
  .include "MovePayload.asm"
  
  ; and now, everything inside the payload!
  .include "payload/RNGGeneratorPayload.asm"
  .include "payload/CharacterSelectCommandsPayload.asm"
  .include "payload/gameplay/RespawnCombosPayload.asm"
  .include "payload/gameplay/NoItemsPayload.asm"
  .include "payload/gameplay/PhysicsPayload.asm"
  .include "payload/gameplay/CharacterStateVisualizerPayload.asm"
  .include "payload/stages/RecyclingPayload.asm"
  .include "payload/stages/WildernessPayload.asm"
  .include "payload/stages/RevolutionPayload.asm"
  .include "payload/stages/SanctuaryPayload.asm"
  .include "payload/stages/GlacierPayload.asm"
  .include "payload/stages/VolcanoPayload.asm"
  .include "payload/TOLockdown/CharacterBansPayload.asm"
  .include "payload/TOLockdown/StageBansPayload.asm"
  .include "payload/TOLockdown/HandicapLockdownPayload.asm"
  
  
  ; I don't have an exact calculation of available space for the payload,
  ; but I do know that the most constraining factor is free RAM.
  ; We move the payload to somewhere that seems reserved for the stack,
  ; but the stack never reaches that far up. This is a liberal guess
  ; at how far up the stack goes and then some for a margin of error.
  ; Even with this conservative estimate how much space is free in RAM,
  ; 0x1FF000 - 0x1FCA00 = 0x2600 bytes for the payload *at least*.
  ; This should *easily* be more than enough, but just in case...
  .if org() > 0x801FF000
    .warning "WARNING: The payload has extended beyond 0x801FF000, there's a chance the payload will get clobbered by the stack!"
  .endif

.close



; game.bin
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/game.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/game.bin",0x800643C0

  .include "game/CharacterStateVisualizerGame.asm"
  .include "game/RespawnCombosGame.asm"
  .include "game/NoItemsGame.asm"
  .include "game/PhysicsGame.asm"
  
  ; Disable 5 Round Limit (removes branch)
  .org 0x800712A8
    nop
  
  ; Basketball & Digi Contest 30 second timer
  .org 0x800D0730
    .halfword 0x384

.close



; title.bin
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/title.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/title.bin",0x800643C0

  .include "title/EverythingUnlockedTitle.asm"
  .include "title/OptionsMenuVariableRedirectsTitle.asm"
  .include "title/MiscQoLTitle.asm"
  .include "title/CharacterSelectCommandsTitle.asm"
  .include "title/TOLockdownTitle.asm"

.close



; st00.bin - Garbage Recycling Center
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/st00.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/st00.bin",0x800D3B00
  .include "st0X/RecycSt.asm"
.close

; st01.bin - Wilderness
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/st01.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/st01.bin",0x800D3B00
  .include "st0X/WildSt.asm"
.close

; st02.bin - Revolution
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/st02.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/st02.bin",0x800D3B00
  ;.include "st0X/RevoSt.asm"
  .include "st0X/RevoSt2.asm"
.close

; st03.bin - Sanctuary
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/st03.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/st03.bin",0x800D3B00
  .include "st0X/SancSt.asm"
.close

; st04.bin - Glacier
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/st04.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/st04.bin",0x800D3B00
  .include "st0X/GlacierSt.asm"
.close

; st05.bin - Volcano
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/st05.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/st05.bin",0x800D3B00
  .include "st0X/VolcanoSt.asm"
.close
