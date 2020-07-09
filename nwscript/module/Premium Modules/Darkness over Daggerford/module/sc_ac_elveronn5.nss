//::///////////////////////////////////////////////
//:: FileName sc_ac_elveronn5
//:: See if player has necklace
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:02:04 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_itm_necklace"))
        return FALSE;

    return TRUE;
}
