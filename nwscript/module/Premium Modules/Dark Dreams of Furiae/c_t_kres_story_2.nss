// (if Day 2 or later
// and have finished conversation 1
// but haven't finished conversation 2)
#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentDay() < 2) return FALSE;
    if(GetLocalInt(GetModule(), "kresh_story_index") != 1) return FALSE;

    return TRUE;
}
