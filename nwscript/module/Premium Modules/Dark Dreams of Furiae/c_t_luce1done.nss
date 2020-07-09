#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();

    if(GetCurrentArea(GetPCSpeaker()) != AREA_GUARD_POST) return FALSE;

    // if you have talked to her once, and not the second time.
    if(GetLocalInt(oModule, "luce_001_done") == TRUE && GetLocalInt(oModule, "luce_002_done") == FALSE) return TRUE;

    return FALSE;
}
