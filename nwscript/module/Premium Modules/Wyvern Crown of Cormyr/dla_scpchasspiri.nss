//::///////////////////////////////////////////////
//:: FileName dla_scpchaswine
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 06/01/2006
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return HasItem(GetPCSpeaker(), "NW_IT_MPOTION022");
}
