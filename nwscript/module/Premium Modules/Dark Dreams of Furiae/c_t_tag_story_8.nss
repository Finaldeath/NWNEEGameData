// (if Day 6 and have finished Conversation 3)
#include "ddf_util"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    if(GetLocalInt(oModule, "tag_story_index") != 3) return FALSE;
    if(GetCurrentDay() < 6) return FALSE;
    //if(GetPartyBackground() != BG_REVOLUTIONARY) return FALSE;

    return TRUE;
}
