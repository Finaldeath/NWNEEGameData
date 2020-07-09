//::///////////////////////////////////////////////
//:: FileName c_y_rev_ring
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2018 1:17:19 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "ddf_util"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_REVOLUTIONARY) return TRUE;
    return FALSE;

    if(!HasItem(GetPCSpeaker(), "RevolutionaryRing"))
        return FALSE;

    return TRUE;
}
