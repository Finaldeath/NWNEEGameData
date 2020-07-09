// (If you've completed Conversation 2 but it's not yet Day 4)
#include "ddf_util"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    if(GetLocalInt(oModule, "tag_story_index") != 2) return FALSE;
    if(GetCurrentDay() >= 4) return FALSE;
    //if(GetPartyBackground() != BG_REVOLUTIONARY) return FALSE;

    return TRUE;
}
