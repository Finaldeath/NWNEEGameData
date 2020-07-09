//::///////////////////////////////////////////////
//:: FileName sc_ac_vladitems1
//:: Check whether player has at least one of the items
//:: for the scavenger hunt quest
//:: Created By: Anya
//:: Created On: 10/15/2005 2:27:03 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    //Set variables
    object oPC = GetPCSpeaker();
    int iPassed = 0;
    // Make sure the PC speaker has one of these items in their inventory
    if(GetItemPossessedBy(oPC, "ac_chalice") != OBJECT_INVALID)
        iPassed = iPassed++;
    if(GetItemPossessedBy(oPC, "ac_sheetmusic") != OBJECT_INVALID)
        iPassed = iPassed++;
    if(GetItemPossessedBy(oPC, "ac_uthgardttotem") != OBJECT_INVALID)
        iPassed = iPassed++;

    if(iPassed == 0)
        return FALSE;
    if(iPassed == 3)
        return FALSE;

    return TRUE;
}

