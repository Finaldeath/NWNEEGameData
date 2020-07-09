//::///////////////////////////////////////////////
//:: dla_atjoustreset
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation action script that removes the indication that a PC has
    accepted a joust match.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 2 Mar 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DLA_RemoveHasJoustMatch(oPC);
    DLA_SetIsOnTraining(oPC, FALSE);
}
