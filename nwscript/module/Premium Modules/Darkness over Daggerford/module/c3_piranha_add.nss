// player has added some piranhas to a pool (OBJECT_SELF)
// .. the piranhas attack any creature standing in the pool

void PiranhasAttack(object oPool, object oPC)
{
    int nType = GetLocalInt(oPool, "POOL_TYPE");
    if (nType != 0)
    {
        SetLocalInt(oPC, "nBitingFish", nType);
        DelayCommand(0.1, ExecuteScript("c3_piranha_pool", oPC));
    }
}

void main()
{
    // the pool now has piranhas inside
    object oPool = OBJECT_SELF;
    SetLocalInt(oPool, "POOL_TYPE", 1);

    // piranhas attack any creature inside
    object oCreature = GetFirstInPersistentObject(oPool, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oCreature))
    {
        SetLocalObject(oCreature, "nBitingFishPool", OBJECT_SELF);
        PiranhasAttack(oPool, oCreature);
        oCreature = GetNextInPersistentObject(oPool, OBJECT_TYPE_CREATURE);
    }
}
