//::///////////////////////////////////////////////
//:: FileName sc_ac_haswhiskyo
//:: Player has whisky, but not whisky with knockout drops
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/24/2005 12:35:30 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ac_harborbottom"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "ac_taintedharbor"))
        return FALSE;

    return TRUE;
}
