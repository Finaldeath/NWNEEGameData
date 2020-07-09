//::///////////////////////////////////////////////
//:: FileName c_has_badge
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-09-21 4:44:57 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "ddf_util"

int StartingConditional()
{
     if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP) return TRUE;
    return FALSE;

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "FuriaeBadge"))
        return FALSE;

    return TRUE;
}
