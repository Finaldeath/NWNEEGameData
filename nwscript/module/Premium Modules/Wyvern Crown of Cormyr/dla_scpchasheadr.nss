// Randomised conditional version if the PC has his/her father's head, in order to trigger 'reminder' responses.
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory & randomise
    if(HasItem(GetPCSpeaker(), "FatherHead") && Random(3) == 0)
        return TRUE;

    return FALSE;
}
