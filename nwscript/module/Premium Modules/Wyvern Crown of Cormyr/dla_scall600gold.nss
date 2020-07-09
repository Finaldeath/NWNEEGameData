// B W-Husey
// Generic conditional. PC has 600 gold

#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the PC speaker has these items in their inventory
    if(GetGold(oPC) > 599)
        return TRUE;

    return FALSE;
}
