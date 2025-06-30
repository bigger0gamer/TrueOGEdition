; Digimon Rumble Arena: True OG Edition
; created by Yuri Bacon
; v2 Refactor
; For more information, check out the README.md
.psx



; TODO LIST:
; - Clean up TrueOG.asm and move as much shit as possible to separate files
;  - If possible, check in with old .asm files to brush up on comments and shit
; - Change respawn combos off to increase the respawn invinciblity instead of changing respawn from launched to knockdown
; - Stage striking
;  - :bc: automatic strike down to legal stages
;  - :bs: to strike stages
;   - striking last available stage should unstrike all stages
; - TO Lockout features
;  - change settings in options as needed
;  - VS CPU -> L2+R2+Select to start
;  - :bs: to (un)ban characters
;  - pick characters to advance
;  - :bs: to ban stages
;  - select stage to go back to back to main menu
;  - select 2P VS to finalize lockout
;  
;  - Prevent leaving 2P VS
;   - Alternatively, if I can figure it out, prevent entering any mode that isn't 2P VS, so you can back out if you choose the wrong character?
;  - Prevent picking banned characters
;  - Prevent altering handicap from 8/8
;  - Prevent picking banned stages
;  - 2 second hold delay on pausing
; 
; WHATS NEW:
; - :bt: on stage/minigame select in all modes, including character preview screen in 1P arcade mode
; - Cyan flash when invincible
; - Yellow flash on stun
; - 



; SLUS_014.04, anything that needs to be inserted into the main executable or payload goes here
; The output file "TITLE_ID" should be replaced by build.sh with a sed command at build time (see build.sh for more info)
.openfile "../build env/Digimon Rumble Arena (US)/SLUS_014.04","../build env/Digimon Rumble Arena (US)/TITLE_ID",0x8000F800

  ; First, we need to start with any data that needs to be modified in SLUS_014.04 itself
  ; All Characters Unlocked
  ; Character Select: Sets all bits in a0 instead of loading unlocked characters from RAM (lazy)
  .org 0x8001D31C
    addi a0,r0,-1
  
  ; Random Music
  .org 0x8001D720 :: RandomMusicReturn:
  .org 0x8001D704 :: ArcadeMusicReturn:
  .org 0x8001D6FC
    j RandomMusic
    lui v1,hi(MusicRNGVar)
  
  ; Alt Color
  .org 0x8001E1CC
    j AltColorsSSS
    lui a0,hi(Color1PVar)
  
  
  ; As most of the game's code can't be resized,
  ; anything that needs extra data has to be stored somewhere else, in unused RAM.
  ; It's stored in empty space at the end of the exe, and this code moves that "payload".
  ; From now, until we close this file, we cannot use .org anymore, so we need to make
  ; any labels for variables and such *before* this point (or where we have another file open)
  .include "MovePayload.asm"
  
  ; and now, everything inside the payload!
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
  .include "payload/RNGGeneratorPayload.asm"
  .include "payload/CharacterSelectCommandsPayload.asm"
  
  
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
  
  
  ; TODO move these closer to relevant functions?
  ; Variable Labels
  .org 0x801FC8F0 :: PhysicsVar:
  .org 0x801FC8F4 :: ItemsVar:
  .org 0x801FC8F8 :: HazardsVar:
  .org 0x801FC8FC :: MusicRNGVar:
  .org 0x801FC900 :: CharacterRNGVar:
  .org 0x801FC904 :: StageRNGVar:
  .org 0x801FC908 :: RespawnVar:
  .org 0x801FC90C :: Color1PVar:
  .org 0x801FC910 :: Color2PVar:
  .org 0x801FC914 :: StateColor:
.close



; game.bin
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/game.bin","../build env/Digimon Rumble Arena (US)/inject/bin/game.bin",0x800643C0

  .include "game/CharacterStateVisualizerGame.asm"
  
  ; Respawn Combo
  .org 0x80070724 :: RespawnComboReturn:
  .org 0x8007071C
    j RespawnCombo
    lui a1,hi(RespawnVar)
  
  ; Disable 5 Round Limit (removes branch)
  .org 0x800712A8
    nop
  
  ; No Items
  .org 0x800C85D4 :: NoItemsReturn:
  .org 0x800C85CC
    j NoItems
    lui s2,hi(ItemsVar)
  
  ; Physics
  .org 0x800772CC :: NormalPhysicsReturn:
  .org 0x800772D4 :: AdjustedPhysicsReturn:
  .org 0x800772C4
    j Physics
    lui v1,hi(PhysicsVar)

.close



; title.bin
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/title.bin","../build env/Digimon Rumble Arena (US)/inject/bin/title.bin",0x800643C0

  .include "title/EverythingUnlockedTitle.asm"
  .include "title/OptionsMenuVariableRedirectsTitle.asm"
  
  ; RNG Generator: We just hook a global frame counter, and use it to make "RNG" counters for
  ; stuff like random character, stage, or music
  .org 0x800752F8 :: RNGReturn:
  .org 0x800752F0
    j RNG
    addiu v0,v0,0x0001  ; original instruction
  
  ; Random Character
  .org 0x800747BC :: RandomCharacterReturn:
  .org 0x800747B4
    j RandomCharacter
    lw v0,0x18(s2)  ; original instruction
  .org 0x800747D8  ; Makes Start (also) select character
    andi v0,s0,0x0840
  
  ; Random Stage
  .org 0x80079188 :: RandomStageReturn:
  .org 0x80079180
    j RandomStage
    andi t0,s5,0x0010
  
  ; Alt Colors
  .org 0x80074934 :: AltColorsCSSReturn:
  .org 0x80074924
    andi a0,s4,0x0108
    sltu a0,r0,a0
    j AltColorsCSS
    lui v0,0x8013
  .org 0x80074938
    andi v0,s4,0x0004
  
  ; Leave "Character Preview" In Arcade Mode
  .org 0x80075F10 :: ArcadeTriangleSaveReturn:
  .org 0x80075F14 :: ArcadeTriangleNoSaveReturn:
  .org 0x80075F04
    andi ra,v0,0x0010
    j ArcadeTriangle
    andi v0,v0,0x0040

.close



; st00.bin - Garbage Recycling Center
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/st00.bin","../build env/Digimon Rumble Arena (US)/inject/bin/st00.bin",0x800D3B00
  .include "st0X/RecycSt.asm"
.close

; st01.bin - Wilderness
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/st01.bin","../build env/Digimon Rumble Arena (US)/inject/bin/st01.bin",0x800D3B00
  .include "st0X/WildSt.asm"
.close

; st02.bin - Revolution
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/st02.bin","../build env/Digimon Rumble Arena (US)/inject/bin/st02.bin",0x800D3B00
  .include "st0X/RevoSt.asm"
.close

; st03.bin - Sanctuary
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/st03.bin","../build env/Digimon Rumble Arena (US)/inject/bin/st03.bin",0x800D3B00
  .include "st0X/SancSt.asm"
.close

; st04.bin - Glacier
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/st04.bin","../build env/Digimon Rumble Arena (US)/inject/bin/st04.bin",0x800D3B00
  .include "st0X/GlacierSt.asm"
.close

; st05.bin - Volcano
.openfile "../build env/Digimon Rumble Arena (US)/vfs/bin/st05.bin","../build env/Digimon Rumble Arena (US)/inject/bin/st05.bin",0x800D3B00
  .include "st0X/VolcanoSt.asm"
.close
