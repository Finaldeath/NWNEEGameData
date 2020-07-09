// PC has Imelda's Note

#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ImeldasNote"))
        return FALSE;

    return TRUE;
}
