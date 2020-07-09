//::///////////////////////////////////////////////
//:: FileName dla_scpchashult
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if PC has a bottle of Hultail Spirits
//
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 14/01/2006
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return HasItem(GetPCSpeaker(), "HultailSpirits");
}
