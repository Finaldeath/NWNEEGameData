// Performs a medium persuade check against the day 3 guard

#include "nw_i0_plot"

void main()
{
    if (AutoDC(DC_MEDIUM, SKILL_PERSUADE, GetPCSpeaker()))
        SetLocalInt(GetModule(), "ddf_day3g_pass", TRUE);
}