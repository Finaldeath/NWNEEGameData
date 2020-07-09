//::///////////////////////////////////////////////
//:: FileName sc_ac_appraise_m
//:: Medium appraise check
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/27/2005 10:46:26 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Perform skill checks
    if(!(AutoDC(DC_MEDIUM, SKILL_APPRAISE, GetPCSpeaker())))
        return FALSE;

    return TRUE;
}
