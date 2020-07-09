//::///////////////////////////////////////////////
//:: FileName sc_ac_vladitems1
//:: Check whether player has all of the items
//:: for the scavenger hunt quest
//:: Created By: Anya
//:: Created On: 10/15/2005 2:27:03 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_chalice"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "ac_sheetmusic"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "ac_uthgardttotem"))
        return FALSE;

    return TRUE;
}
