#include "nw_i0_plot"
int StartingConditional()
{
    // Perform skill checks
    if(!(AutoDC(DC_SUPERIOR, SKILL_HEAL, GetPCSpeaker())))
    return FALSE;
    return TRUE;
}

