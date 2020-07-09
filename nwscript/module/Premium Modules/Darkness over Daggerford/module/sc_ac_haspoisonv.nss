//::///////////////////////////////////////////////
//:: FileName sc_ac_haspoisonv
//:: See if player has poison vial in inventory
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 10:57:42 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_itm_poisonv"))
        return FALSE;

    return TRUE;
}
