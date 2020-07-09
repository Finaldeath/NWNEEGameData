//::///////////////////////////////////////////////
//:: FileName dla_scpchashorn
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if PC has an Unicorn Horn
//
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 03/12/2005
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Make sure the PC speaker has these items in their inventory
    return HasItem(GetPCSpeaker(), "UnicornHorn");
}
