//::///////////////////////////////////////////////
//:: dla_scjoustdef1
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional script that checks if PC can select defense position 1 in a
   conversation.
*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: Feb 26, 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return DLA_GetIsDefPosValid(DLA_GetAimPos(oPC), DLA_JOUST_DEF_HELM, DLA_GetStunCondition(oPC));
}
