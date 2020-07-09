// January 2006
// B W-Hsuey
//PC has White Stag Hide (either in good or poor condition)
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "WhiteStagOK") || HasItem(GetPCSpeaker(), "WhiteStagBad"))
        return TRUE;

    return FALSE;
}
