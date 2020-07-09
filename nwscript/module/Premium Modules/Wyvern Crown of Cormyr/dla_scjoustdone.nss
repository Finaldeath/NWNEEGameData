//::///////////////////////////////////////////////
//:: dla_scjoustdone
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Check if oPC has more matches than wins (he has lost)

    Use this check ONLY after you have done any plot state checks and/or win
    checks.
*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: Feb 26, 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_DONE)) return TRUE;
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_DONE) &&
        GetLocalInt(oPC, "nMainPlot")<7) return TRUE;
    return FALSE;
}
