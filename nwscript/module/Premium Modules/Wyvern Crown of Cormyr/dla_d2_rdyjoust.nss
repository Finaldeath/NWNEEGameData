//::///////////////////////////////////////////////
//:: dla_d2_rdyjoust
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Joust conversation conditional script that returns TRUE if the character has
   everything needed to participate in a joust.
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
 return DLA_GetIsWarhorse(oPC);
}
