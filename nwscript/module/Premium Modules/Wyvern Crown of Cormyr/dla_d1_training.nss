//::///////////////////////////////////////////////
//:: dla_d2_opponent
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conversation action script that sets oPC to training status
    (used in the text appears option for node requesting training on
      the squires conversation).
*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: Feb 28, 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    DLA_SetIsOnTraining(GetPCSpeaker(), TRUE);
    return TRUE;
}
