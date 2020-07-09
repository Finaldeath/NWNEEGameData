//::///////////////////////////////////////////////
//:: FileName sc_ac_hastainted
//:: See if player has whisky mixed with knockout drops in inventory
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/24/2005 12:26:46 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_taintedharbor"))
        return FALSE;

    return TRUE;
}
