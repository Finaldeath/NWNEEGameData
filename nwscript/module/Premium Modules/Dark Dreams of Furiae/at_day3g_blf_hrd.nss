// Performs a hard bluff check against the day 3 guard

#include "nw_i0_plot"

void main()
{
    if (AutoDC(DC_HARD, SKILL_BLUFF, GetPCSpeaker()))
        SetLocalInt(GetModule(), "ddf_day3g_pass", TRUE);
}
