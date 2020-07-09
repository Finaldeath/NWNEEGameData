//Does the PC have a Harper Pin

#include "nw_i0_tool"

int StartingConditional()
{
    if(HasItem(GetPCSpeaker(), "HarperPin"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
