// B W-Husey
// Generic conditional. PC has 150 gold

#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the PC speaker has these items in their inventory
    if(GetGold(oPC) > 149)
        return TRUE;

    return FALSE;
}
