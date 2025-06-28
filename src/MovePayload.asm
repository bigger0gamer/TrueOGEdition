.psx

.org 0x801FCA00
PayloadDestination:

.org 0x8003DD58
MovePayloadReturn:


; This is the first instruction the game runs after the BIOS hands over control.
; We'll replace the first 2 instructions to jump to extra space in the exe
; before anything else gets loaded in.
.org 0x8003DD50
  j MovePayload
  lui v0,hi(Payload)

; Main function!
.org 0x800643C0 :: MovePayload:
  addiu v0,v0,lo(Payload)  ; v0 = start of payload
  addiu v1,v0,0x30EC       ; v1 = end of payload (fixed size based on estimated free RAM space)
  li a0,PayloadDestination ; a0 = RAM location to move payload to
  
  @@StartOfLoop:
  lw a1,0x0000(v0)   ; load first 4 bytes of payload into a1
  lw a2,0x0004(v0)   ; while we wait on a1, we load the next 4 bytes into a2
  sw a1,0x0000(a0)   ; hey, a1 loaded just in time to save it!
  sw a2,0x0004(a0)   ; a2 too!
  addiu v0,v0,0x8    ; increment v0 by 2 words
  addiu a0,a0,0x8    ; a0 too
  sltu at,v0,v1      ; we there yet?
  bne at,r0,@@StartOfLoop  ; no? Ugh, we have to go back again
  nop
  lui v0,0x800E      ; original instruction
  j MovePayloadReturn  ; jump back to original code
  addiu v0,v0,0xA600 ; original instruction


Payload:
.headersize PayloadDestination-orga(Payload)
; This label is intentionally at the end of the file (right after the main func), so that
; payload always refers to file offset after where MovePayload exists in SLUS_014.04,
; so that TrueOG.asm can start including other asm files right after as part of the payload.
; Then we update the header offset for where the rest of the code will exist in RAM at run time.
