//::///////////////////////////////////////////////
//:: FileName sc_ac_has_recipe
//:: See if the player has the cider recipe
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/11/2005 11:39:14 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_ciderrecipe"))
        return FALSE;

    return TRUE;
}
