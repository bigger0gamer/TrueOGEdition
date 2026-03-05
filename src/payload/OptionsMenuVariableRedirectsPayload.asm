.psx

OptionsMenuGameplayVar:
  srl at,a0,1
  sb at,lo(PhysicsVar)(v1)
  li a1,0x801CEDA0
  sb at,0(a1)
  sb at,lo(ItemsVar)(v1)
  slti a0,a0,1
  slti a0,a0,1
  sb a0,lo(WakeupVar)(v1)
  li a1,0x801CEE18
  sb a0,lo(RespawnVar)(v1)
  j 0x8006BC10
  sb a0,0(a1)
