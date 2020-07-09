//::///////////////////////////////////////////////
//:: ndt_a0_bloodsail
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the on death event that works with
    script "phb_a0_spwnbld" to respawn fallen
    blood sailors.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "inc_bootysystem"

void ClearAndClean(object oSelf = OBJECT_SELF);

void main()
{
    object oSelf = OBJECT_SELF;
    object oKiller = GetLastKiller();
    object oSpawn = GetObjectByTag("a0_spwnbld");

    string sResRef = GetResRef(oSelf);
    int iCounter = GetLocalInt(oSpawn, "iBLDCounter") + 1;

    SetLocalInt(oSpawn, "iBLDCounter", iCounter);
    SetLocalString(oSpawn, "sResRef" + IntToString(iCounter), sResRef);

    if ((GetIsPC(oKiller) == TRUE) || (GetIsPC(GetMaster(oKiller)) == TRUE)
        || (GetIsPC(GetAreaOfEffectCreator(oKiller)) == TRUE))
    {
        //generate additional treasure
    }
    else
    {
        ClearAndClean();
    }
}

void ClearAndClean(object oSelf = OBJECT_SELF)
{
    object oItem = GetFirstItemInInventory(oSelf);

    while (GetIsObjectValid(oItem) == TRUE)
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oSelf);
    }

    SetLootable(oSelf, TRUE);
}
