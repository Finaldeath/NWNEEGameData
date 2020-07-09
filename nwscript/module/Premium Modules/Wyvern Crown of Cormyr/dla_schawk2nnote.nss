//PC has forgotten to bring Imelda's note

#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ImeldasNote"))
        return TRUE;

    return FALSE;
}
