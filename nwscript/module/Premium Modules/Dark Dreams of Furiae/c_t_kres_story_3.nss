// (if Day 3 or later
// and have finished conversation 2
// but haven't finished conversation 3)
#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentDay() < 3) return FALSE;
    if(GetLocalInt(GetModule(), "kresh_story_index") != 2) return FALSE;

    return TRUE;
}
