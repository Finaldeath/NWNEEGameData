// the player has added a jar of piranhas into one of the pools

#include "hf_in_plot"

void main()
{
    // destroy the jar of piranhas
    object oPC = GetPCSpeaker();
    object oJar = GetItemPossessedBy(oPC, "ks_it_piranhas");
    DestroyObject(oJar);

    // flag that piranhas are in the pool
    string sTag = GetTag(OBJECT_SELF);
    PlotLevelSet(sTag, 1);

    // trigger the piranhas to attack any creatures in the pool
    object oPool = GetNearestObjectByTag("PiranhaPool", oPC);
    if (GetIsObjectValid(oPool))
    {
        SetLocalInt(oPool, "POOL_TYPE", 1);
        ExecuteScript("c3_piranha_add", oPool);
    }
}
