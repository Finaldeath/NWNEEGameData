//::///////////////////////////////////////////////
//:: dla_scjoustopis8
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script that returns TRUE if the joust
    opponent is opponent #7
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: Mar 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    if(DLA_GetIsOpponentNumber(GetPCSpeaker(),7)) return TRUE;
    return FALSE;
}
