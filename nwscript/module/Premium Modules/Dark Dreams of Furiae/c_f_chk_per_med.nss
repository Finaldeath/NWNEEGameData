// Returns whether the player FAILED a medium-difficulty persuade check

#include "nw_i0_plot"

int StartingConditional()
{
    if (AutoDC(DC_MEDIUM, SKILL_PERSUADE, GetPCSpeaker()))
        return FALSE;

    return TRUE;
}
