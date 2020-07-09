#include "hf_in_plot"

int StartingConditional()
{

    // If failed miller quest and not shown Conway's note, store closed
    if((GetLocalInt(GetPCSpeaker(), "ac_miller_quest") == 6) &&
        PlotLevelGet(GetTag(OBJECT_SELF)) < 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}
