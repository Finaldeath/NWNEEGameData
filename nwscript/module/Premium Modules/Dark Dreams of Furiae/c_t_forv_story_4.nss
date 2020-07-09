// (if at least day 5
// and have finished conversation 3
// and not yet finished conversation 4)

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    if (GetCurrentDay() < 5) return FALSE;
    if (GetLocalInt(oModule, "forvor_story_index") != 3) return FALSE;

    return TRUE;
}
