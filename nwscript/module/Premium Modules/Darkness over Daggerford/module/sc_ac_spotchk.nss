//::///////////////////////////////////////////////
//:: FileName sc_ac_spotchk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/28/2005 1:58:49 PM
//:: Perform a spot check at medium difficulty.
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Perform skill checks
    if(!(AutoDC(DC_MEDIUM, SKILL_SPOT, GetPCSpeaker())))
        return FALSE;

    return TRUE;
}
