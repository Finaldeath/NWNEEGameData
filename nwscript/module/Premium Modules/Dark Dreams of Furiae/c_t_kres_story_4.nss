// (if Day 4 or later
// and have finished conversation 3
// but haven't finished conversation 4)
#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentDay() < 4) return FALSE;
    if(GetLocalInt(GetModule(), "kresh_story_index") != 3) return FALSE;

    return TRUE;
}
