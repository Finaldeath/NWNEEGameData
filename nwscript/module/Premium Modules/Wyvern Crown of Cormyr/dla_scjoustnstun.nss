//::///////////////////////////////////////////////
//:: dla_scjoustnstun
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script that returns TRUE if the player is NOT
    in a shaken or stunned condition
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    return (DLA_GetStunCondition(GetPCSpeaker()) < DLA_JOUST_CONDITION_STUNNED);
}
