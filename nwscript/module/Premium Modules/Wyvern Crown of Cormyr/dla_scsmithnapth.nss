//::///////////////////////////////////////////////
//:: FileName dla_scsmithnapth
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 29/10/2005
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return HasItem(GetPCSpeaker(), "NapthaBlend");
}
