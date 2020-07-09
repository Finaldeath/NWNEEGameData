//::///////////////////////////////////////////////
//:: dla_scjoustopis8
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script that returns TRUE if the joust
    opponent is opponent #2
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: Mar 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    if(DLA_GetIsOpponentNumber(GetPCSpeaker(),2)) return TRUE;
    return FALSE;
}
