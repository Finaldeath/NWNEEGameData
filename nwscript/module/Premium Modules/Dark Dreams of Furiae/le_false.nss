//::///////////////////////////////////////////////
//:: FileName c_badge_false
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-09-21 4:44:57 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "ddf_util"

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP) return FALSE;
    return TRUE;

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "FuriaeBadge"))
        return FALSE;

    return TRUE;
}