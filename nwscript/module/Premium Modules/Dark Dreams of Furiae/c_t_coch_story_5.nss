// (if at least Day 5
// and have finished conversation 3)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    if(GetCurrentDay() < 5) return FALSE;

    if(GetLocalInt(oModule, "cochrane_story_index") != 3) return FALSE;

    //if(GetPartyBackground() != BG_COP) return FALSE;

    return TRUE;
}
