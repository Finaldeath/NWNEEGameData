// (if at least day 2
// and have finished conversation 1
// and not yet finished conversation 2)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    if (GetCurrentDay() < 2) return FALSE;
    if (GetLocalInt(oModule, "forvor_story_index") != 1) return FALSE;

    return TRUE;
}
