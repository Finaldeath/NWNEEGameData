// (if at least Day 4
// and have finished conversation 2)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    if(GetCurrentDay() < 4) return FALSE;

    if(GetLocalInt(oModule, "cochrane_story_index") != 2) return FALSE;

    //if(GetPartyBackground() != BG_COP) return FALSE;

    return TRUE;
}
