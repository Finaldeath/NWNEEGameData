// player enters piranha pool

void main()
{
    object oPC = GetEnteringObject();
    int nType = GetLocalInt(OBJECT_SELF, "POOL_TYPE");
    if (nType != 0)
    {
        SetLocalInt(oPC, "nBitingFish", nType);
        SetLocalObject(oPC, "nBitingFishPool", OBJECT_SELF);
        DelayCommand(0.1, ExecuteScript("c3_piranha_pool", oPC));
    }
    ExecuteScript("c2_oe_wafootstep", OBJECT_SELF);
}
