// Returns whether the player PASSED a medium-difficulty intimidate check

#include "nw_i0_plot"

int StartingConditional()
{
    if(AutoDC(DC_MEDIUM, SKILL_INTIMIDATE, GetPCSpeaker()))
        return TRUE;

    return FALSE;
}
