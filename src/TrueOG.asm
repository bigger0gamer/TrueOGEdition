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
   .org 0x80107744 :: Player1StatePointer:
   .org 0x8011424C :: Player1HeldInputs:
   .org 0x801142E4 :: Player2HeldInputs:
   .org 0x80064E90 :: PauseTextPointer:
   .org 0x8012AAA4 :: CSSModePointer:
   .org 0x8012AA5C :: Player1CursorFlash:
   
   ; 1 byte vars
   .org 0x801FC8F0 :: PhysicsVar:
   .org 0x801FC8F1 :: HazardsVar:
   .org 0x801FC8F2 :: ItemsVar:
   .org 0x801FC8F3 :: RespawnVar:
   .org 0x801FC8F4 :: Color1PVar:
   .org 0x801FC8F5 :: Color2PVar:
   .org 0x801FC8F6 :: TOLockdown:
   .org 0x801FC8F7 :: WakeupVar:
   .org 0x801FC8F8 :: MusicVar:
   
   ; 16 byte vars
   .org 0x801FC900 :: CharacterRNGHistory:
   .org 0x801FC910 :: MusicRNGHistory:
   
   ; 12 byte var
   .org 0x801FC920 :: StateColor:
   
   ; 4 byte vars
   .org 0x801FC92C :: CharacterStageBans:
   .org 0x801FC930 :: NoHazCustomVar:
   .org 0x801FC934 :: Player2StatePointer:
   .org 0x801FC938 :: StageRNGHistory:
  
  
  ; First, we need to start with any data that needs to be modified in SLUS_014.04 itself
  .include "exe/EverythingUnlockedExe.asm"
  .include "exe/RandomMusicExe.asm"
  .include "exe/AltColorExe.asm"
  .include "exe/TOLockdownExe.asm"
  
  
  ; As most of the game's code can't be resized,
  ; anything that needs extra data has to be stored somewhere else, in unused RAM.
  ; It's stored in empty space at the end of the exe, and this code moves that "payload".
  ; From now, until we close this file, we cannot use .org anymore, so we need to make
  ; any labels for variables and such *before* this point (or where we have another file open)
  .include "MovePayload.asm"
  
  ; and now, everything inside the payload!
  .include "payload/RNGGeneratorPayload.asm"
  .include "payload/CharacterSelectCommandsPayload.asm"
  .include "payload/OptionsMenuVariableRedirectsPayload.asm"
  .include "payload/gameplay/RespawnCombosPayload.asm"
  .include "payload/gameplay/NoItemsPayload.asm"
  .include "payload/gameplay/PhysicsPayload.asm"
  .include "payload/gameplay/CharacterStateVisualizerPayload.asm"
  .include "payload/gameplay/AutoSkipKOPayload.asm"
  .include "payload/gameplay/WakeupInvincPayload.asm"
  .include "payload/stages/RecyclingPayload.asm"
  .include "payload/stages/WildernessPayload.asm"
  .include "payload/stages/RevolutionPayload.asm"
  .include "payload/stages/SanctuaryPayload.asm"
  .include "payload/stages/GlacierPayload.asm"
  .include "payload/stages/VolcanoPayload.asm"
  .include "payload/TOLockdown/CharacterBansPayload.asm"
  .include "payload/TOLockdown/StageBansPayload.asm"
  .include "payload/TOLockdown/HandicapLockdownPayload.asm"
  .include "payload/TOLockdown/MainMenuLockdownPayload.asm"
  .include "payload/TOLockdown/PauseLockdownPayload.asm"
  
  
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
  .include "game/WildMoveRespawnsGame.asm"
  .include "game/AutoSkipKOGame.asm"
  .include "game/WakeupInvincGame.asm"
  
  ; Disable 5 Round Limit (removes branch)
  .org 0x800712A8
    nop
  
  ; Basketball & Digi Contest 30 second timer
  .org 0x800D0730
    .halfword 0x384
  
  ; "Continue" -> "1P Pause"
  .org 0x80064E90
    .ascii "1P Pause"

.close



; title.bin
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/bin/title.bin","../build env/Digimon Rumble Arena (USA)/inject/bin/title.bin",0x800643C0

  .include "title/EverythingUnlockedTitle.asm"
  .include "title/OptionsMenuVariableRedirectsTitle.asm"
  .include "title/MiscQoLTitle.asm"
  .include "title/CharacterSelectCommandsTitle.asm"
  .include "title/TOLockdownTitle.asm"

.close



; HazardsVar
; 0 - True OG (New No Hazards)
; 1 - Legacy (Old No Hazards from True OG v1)
; 2 - Original (No Changes)

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
  .include "st0X/RevoSt.asm"
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



; Textures!
; In the past, I would just use tim2view to extract & inject individual textues into the
; "bundles" (tims appended onto each other) that the game uses. Now, I just use it to
; extract them. It thankfully gives me the offset, so I can inject them back this way.

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/system/system.tim","../build env/Digimon Rumble Arena (USA)/inject/system/system.tim",0
  
  ; Now Loading
  .orga 0x15D60 :: .import "textures/system/system.tim/now_loading/now_loading.tim"
  .orga 0x163A0 :: .import "textures/system/system.tim/now_loading_shadow/now_loading_shadow.tim"
  
  ; Stage Icons
  .orga 0x08020 :: .import "textures/system/system.tim/recycling/recycling.tim"
  .orga 0x09640 :: .import "textures/system/system.tim/wilderness/wilderness.tim"
  .orga 0x0AC60 :: .import "textures/system/system.tim/revolution/revolution.tim"
  .orga 0x0C280 :: .import "textures/system/system.tim/sanctuary/sanctuary.tim"
  .orga 0x0D8A0 :: .import "textures/system/system.tim/glacier/glacier.tim"
  .orga 0x0EEC0 :: .import "textures/system/system.tim/volcano/volcano.tim"
  .orga 0x104E0 :: .import "textures/system/system.tim/reapermons_den/reapermons_den.tim"
  .orga 0x11B00 :: .import "textures/system/system.tim/basketball/basketball.tim"
  .orga 0x13120 :: .import "textures/system/system.tim/digi_contest/digi_contest.tim"
  .orga 0x14740 :: .import "textures/system/system.tim/gems/gems.tim"
  
.close


; "Left" side
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/l05.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/l05.tim",0
  
  .orga 0x0017 :: .byte 0x80  ; IDM SSS
  .orga 0x4A37 :: .byte 0x80  ; Tamer SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/l06.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/l06.tim",0
  
  .orga 0x0017 :: .byte 0x80, 0x00, 0x80  ; IDMP SSS
  .orga 0x4A37 :: .byte 0x80              ; Tamer SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/l16.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/l16.tim",0
  
  .orga 0x0017 :: .byte 0x80, 0x00, 0x80  ; Sting SSS
  .orga 0x4A37 :: .byte 0x80, 0x00, 0x80  ; Tamer SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/l19.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/l19.tim",0
  
  .orga 0x0017 :: .byte 0x80, 0x00, 0x80, 0x00, 0x80  ; Veemon SSS
  .orga 0x22B7 :: .byte 0x80, 0x00, 0x80              ; IDM SSS
  .orga 0x6CD7 :: .byte 0x80                          ; Tamer SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/l20.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/l20.tim",0
  
  .orga 0x0017 :: .byte 0x80              ; Wormmon SSS
  .orga 0x22B7 :: .byte 0x80, 0x00, 0x80  ; Stingmon SSS
  .orga 0x6CD7 :: .byte 0x80, 0x00, 0x80  ; Tamer SSS
  
.close

; "Right" side
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/r05.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/r05.tim",0
  
  .orga 0x0017 :: .byte 0x80, 0x00, 0x80  ; IDM SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/r06.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/r06.tim",0
  
  .orga 0x0017 :: .byte 0x80  ; IDMP SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/r13.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/r13.tim",0
  
  ; fuuuuggggggg the rika texture god damn
  ;.orga 0x4C38 :: .byte 0xAA
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/r16.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/r16.tim",0
  
  .orga 0x0017 :: .byte 0x80, 0x00, 0x80  ; Sting SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/r19.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/r19.tim",0
  
  .orga 0x0017 :: .byte 0x80, 0x00, 0x80, 0x00, 0x80  ; Veemon SSS
  .orga 0x22B7 :: .byte 0x80, 0x00, 0x80              ; IDM SSS
  
.close

.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/map/r20.tim","../build env/Digimon Rumble Arena (USA)/inject/title/map/r20.tim",0
  
  .orga 0x0017 :: .byte 0x80              ; Wormmon SSS
  .orga 0x22B7 :: .byte 0x80, 0x00, 0x80  ; Stingmon SSS
  
.close


; Character Select
.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/charasel.tim","../build env/Digimon Rumble Arena (USA)/inject/title/charasel.tim",0
  
  ; Fix various character select "black is transparent" mistakes
  .orga 0x1C417 :: .byte 0x80                          ; Wargreymon name plate
  .orga 0x15397 :: .byte 0x80                          ; Guilmon name plate
  .orga 0x2DE97 :: .byte 0x80, 0x00, 0x80, 0x00, 0x80  ; IDM CSS
  .orga 0x522D7 :: .byte 0x80                          ; Stingmon CSS
  .orga 0x58C57 :: .byte 0x80, 0x00, 0x80, 0x00, 0x80  ; Terriermon CSS
  .orga 0x5C117 :: .byte 0x80, 0x00, 0x80, 0x00, 0x80  ; Veemon CSS
  .orga 0x5F5D7 :: .byte 0x80                          ; Wormmon CSS
  
.close


.openfile "../build env/Digimon Rumble Arena (USA)/vfs/title/option.tim","../build env/Digimon Rumble Arena (USA)/inject/title/option.tim",0
  
  ; Entire Options Menu
  .orga 0x01400 :: .import "textures/title/option.tim/setting_0_name/setting_0_name.tim"
  .orga 0x01840 :: .import "textures/title/option.tim/setting_1_name/setting_1_name.tim"
  .orga 0x01C80 :: .import "textures/title/option.tim/setting_2_name/setting_2_name.tim"
  .orga 0x020C0 :: .import "textures/title/option.tim/setting_3_name/setting_3_name.tim"
  .orga 0x02500 :: .import "textures/title/option.tim/setting_4/setting_4.tim"
  .orga 0x02A40 :: .import "textures/title/option.tim/setting_5/setting_5.tim"
  .orga 0x02F80 :: .import "textures/title/option.tim/setting_6/setting_6.tim"
  .orga 0x034C0 :: .import "textures/title/option.tim/setting_7/setting_7.tim"
  .orga 0x03A00 :: .import "textures/title/option.tim/setting_8/setting_8.tim"
  .orga 0x03F40 :: .import "textures/title/option.tim/setting_0_0/setting_0_0.tim"
  .orga 0x04380 :: .import "textures/title/option.tim/setting_0_1/setting_0_1.tim"
  .orga 0x047C0 :: .import "textures/title/option.tim/setting_0_2/setting_0_2.tim"
  .orga 0x04C00 :: .import "textures/title/option.tim/setting_1_0/setting_1_0.tim"
  .orga 0x05040 :: .import "textures/title/option.tim/setting_1_1/setting_1_1.tim"
  .orga 0x05480 :: .import "textures/title/option.tim/setting_2_0/setting_2_0.tim"
  .orga 0x058C0 :: .import "textures/title/option.tim/setting_2_1/setting_2_1.tim"
  .orga 0x05D00 :: .import "textures/title/option.tim/setting_3_0/setting_3_0.tim"
  .orga 0x06140 :: .import "textures/title/option.tim/setting_3_1/setting_3_1.tim"
  .orga 0x0FBC0 :: .import "textures/title/option.tim/con_header/con_header.tim"
  .orga 0x0FF00 :: .import "textures/title/option.tim/con_0/con_0.tim"
  .orga 0x11980 :: .import "textures/title/option.tim/con_4/con_4.tim"
  .orga 0x11DC0 :: .import "textures/title/option.tim/con_5/con_5.tim"
  .orga 0x12200 :: .import "textures/title/option.tim/con_7/con_7.tim"
  .orga 0x12740 :: .import "textures/title/option.tim/con_1/con_1.tim"
  .orga 0x12B80 :: .import "textures/title/option.tim/con_2/con_2.tim"
  .orga 0x12FC0 :: .import "textures/title/option.tim/con_3/con_3.tim"
  .orga 0x13400 :: .import "textures/title/option.tim/con_6/con_6.tim"
  
.close
