//::///////////////////////////////////////////////
//:: FileName dla_scsmithbodak
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if PC has a Bodak Tooth
//
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 10/01/2006
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC06");
}
