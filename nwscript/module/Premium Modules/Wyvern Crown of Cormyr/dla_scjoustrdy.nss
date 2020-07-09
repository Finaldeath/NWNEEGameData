//::///////////////////////////////////////////////
//:: dla_scjoustrdy
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Check if the character have everything needed to participate on joust
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: May 22, 2005
//:://////////////////////////////////////////////

#include "dla_inc_ride"
#include "dla_i0_joust"

int DLA_GetHasAllEquipForJoust(object oPC);

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return DLA_GetHasAllEquipForJoust(oPC);
}

int DLA_GetHasAllEquipForJoust(object oPC)
{
    return DLA_GetMountIsWarhorse(oPC);
}
