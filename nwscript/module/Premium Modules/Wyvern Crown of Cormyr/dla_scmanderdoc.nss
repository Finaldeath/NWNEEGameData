// October 2005
// B W-Husey
// PC is carrying the witness doc.

#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "WitnessDoc"))
        return FALSE;

    return TRUE;
}
