// B W-Husey
// Generic conditional. PC has at least 8 GP

#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the PC speaker has these items in their inventory
    if(GetGold(oPC) > 7)
        return TRUE;

    return FALSE;
}
