//::///////////////////////////////////////////////
//:: cac_a2_pftoken
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the name of the weapon the user placed in
    the forge into the custom token
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 17, 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

void main()
{
    object oSpeaker = GetPCSpeaker();
    object oForge = GetNearestObjectByTag("a2_prugforge");
    object oItem = GetFirstItemInInventory(oForge);
    string sWeaponName = "";

    if (GetIsObjectValid(oItem) == TRUE)
    {
        sWeaponName = GetName(oItem);
    }
    else
    {
        return;
    }

    SetCustomToken(WeaponToken, sWeaponName);
}
