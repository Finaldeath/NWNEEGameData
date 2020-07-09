//::///////////////////////////////////////////////
//:: dla_scnojoust
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script that returns TRUE if oPC is not able
    to joust in either tournament.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nMainPlot = GetLocalInt(oPC, "nMainPlot");
    int nJoustState = DLA_GetJoustState(oPC);
    int bJoust1 = (nMainPlot==1 && DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_STARTED));
    int bJoust2 = (nMainPlot==7 && DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED));
    if (bJoust1 | bJoust2) return FALSE;
    return TRUE;
}
