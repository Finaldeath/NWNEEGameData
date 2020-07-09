#include "nw_i0_tool"

int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "a2_pm_fernigold"))
        return TRUE;

    return FALSE;
}
