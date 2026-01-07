.psx

  ; Physics
  .org 0x800772CC :: NormalPhysicsReturn:
  .org 0x800772D4 :: AdjustedPhysicsReturn:
  .org 0x800772C4
    j Physics
    lui v1,hi(PhysicsVar)
