// January 2006
// B W-Hsuey
//PC has White Stag Hide (in good condition)
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "WhiteStagOK"))
        return TRUE;

    return FALSE;
}
