//January 2006
// B W-Husey
// The PC has a rope and a horse


//#include "nw_i0_tool"
#include "dla_i0_horse"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(oPC, "Rope") || DLA_GetNumHorsesOwned(oPC)==0)
        return FALSE;

    return TRUE;
}
