// (If you've completed Conversation 1 but it's not yet Day 2)
#include "ddf_util"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    if(GetLocalInt(oModule, "tag_story_index") != 1) return FALSE;
    if(GetCurrentDay() > 1) return FALSE;
    //if(GetPartyBackground() != BG_REVOLUTIONARY) return FALSE;

    return TRUE;
}
