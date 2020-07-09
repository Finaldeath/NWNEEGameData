//::///////////////////////////////////////////////
//:: FileName sc_ac_hasholyh2o
//:: See if player has holy water
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:19:33 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "X1_WMGRENADE005"))
        return FALSE;

    return TRUE;
}
