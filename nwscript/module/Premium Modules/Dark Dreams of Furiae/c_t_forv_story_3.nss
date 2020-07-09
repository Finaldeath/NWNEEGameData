// (if at least day 3
// and have finished conversation 2
// and not yet finished conversation 3)

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    if (GetCurrentDay() < 3) return FALSE;
    if (GetLocalInt(oModule, "forvor_story_index") != 2) return FALSE;

    return TRUE;
}
