//::///////////////////////////////////////////////
//:: dla_scjoust1done
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation script that returns TRUE if the first joust tournament
    has been completed
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//::////////////////////////////////////////////////::///////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_DONE))
        return TRUE;
    return FALSE;
}
