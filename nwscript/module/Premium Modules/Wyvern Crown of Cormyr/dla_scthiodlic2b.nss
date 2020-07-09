//January 2006
// B W-Husey
// PC has picked up father's will, but that's all.
#include "nw_i0_tool"
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nGrave") > 1)
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "KnowLic") >0))
        return FALSE;
    // Make sure the PC speaker does not have these items in their inventory
    if(HasItem(GetPCSpeaker(), "licence"))
        return FALSE;

    return TRUE;
}


