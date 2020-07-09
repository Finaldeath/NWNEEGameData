//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_sharcon
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Text appears when PC has contract.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "Contract"))
        return FALSE;

    return TRUE;
}
