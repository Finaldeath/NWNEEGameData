//::///////////////////////////////////////////////
//:: FileName sc_ac_listenchk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/28/2005 1:54:57 PM
//:: Make a listen check at medium difficulty.
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Perform skill checks
    if(!(AutoDC(DC_MEDIUM, SKILL_LISTEN, GetPCSpeaker())))
        return FALSE;

    return TRUE;
}
