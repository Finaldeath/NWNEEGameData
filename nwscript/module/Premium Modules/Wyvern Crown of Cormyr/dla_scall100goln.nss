// B W-Husey
// Generic conditional. PC does not have 100 gold

#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the PC speaker has these items in their inventory
    if(GetGold(oPC) > 99)
        return FALSE;

    return TRUE;
}
