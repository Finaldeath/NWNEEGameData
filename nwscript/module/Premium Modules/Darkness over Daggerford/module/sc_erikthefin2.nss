//::///////////////////////////////////////////////
//:: FileName sc_erikthefin2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 15/11/2005 12:51:12
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "a2_pm_impchest2"))
        return FALSE;

    return TRUE;
}
