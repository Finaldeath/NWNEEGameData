// (else If haven't finished Conversation 1 yet)
#include "ddf_util"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    if(GetLocalInt(oModule, "tag_story_index") > 0) return FALSE;
    //if(GetPartyBackground() != BG_REVOLUTIONARY) return FALSE;

    return TRUE;
}
