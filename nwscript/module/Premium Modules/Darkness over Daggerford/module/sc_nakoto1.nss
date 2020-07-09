// does the player have bugo's letter?

#include "nw_i0_tool"

int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "pm_bugo_letter"))
        return FALSE;
    return TRUE;
}
