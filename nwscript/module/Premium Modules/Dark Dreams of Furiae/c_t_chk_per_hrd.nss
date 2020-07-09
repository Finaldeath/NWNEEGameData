// Returns whether the player PASSED a hard-difficulty persuade check

#include "nw_i0_plot"

int StartingConditional()
{
    if (AutoDC(DC_HARD, SKILL_PERSUADE, GetPCSpeaker()))
        return TRUE;

    return FALSE;
}
