// (if at least Day 2
// and have finished conversation 1
// and if Law Enforcement)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    if(GetCurrentDay() < 2) return FALSE;

    if(GetLocalInt(oModule, "cochrane_story_index") != 1) return FALSE;

    if(GetPartyBackground() != BG_COP) return FALSE;

    return TRUE;
}
