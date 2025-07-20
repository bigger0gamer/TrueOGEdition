.psx

  ; No Items
  .org 0x800C85D4 :: NoItemsReturn:
  .org 0x800C85CC
    j NoItems
    lui s2,hi(ItemsVar)
