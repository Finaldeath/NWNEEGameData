//::///////////////////////////////////////////////
//:: FileName dla_scpchashead
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if PC has Father's Head on inventory
//
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 02/01/2006
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return HasItem(GetPCSpeaker(), "FatherHead");
}
