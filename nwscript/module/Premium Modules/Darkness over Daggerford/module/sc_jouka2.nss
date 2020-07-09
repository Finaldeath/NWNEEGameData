//::///////////////////////////////////////////////
//:: FileName sc_jouka2
//:: Check whether player has Jouka's awl in their inventory
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 4/9/2006 5:21:52 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_joukasawl"))
        return FALSE;

    return TRUE;
}
