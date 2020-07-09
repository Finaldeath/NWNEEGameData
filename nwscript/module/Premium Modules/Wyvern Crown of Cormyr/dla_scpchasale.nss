//::///////////////////////////////////////////////
//:: FileName dla_scpchaswine
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if PC owns at least 1 bottle of ale
//
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 16/07/2006
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return (HasItem(GetPCSpeaker(), "NW_IT_MPOTION021"));
}
