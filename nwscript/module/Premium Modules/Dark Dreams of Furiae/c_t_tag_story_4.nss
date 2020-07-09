// (if at least Day 2 and have finished conversation 1)
#include "ddf_util"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    if(GetLocalInt(oModule, "tag_story_index") != 1) return FALSE;
    if(GetCurrentDay() < 2) return FALSE;
    //if(GetPartyBackground() != BG_REVOLUTIONARY) return FALSE;

    return TRUE;
}
