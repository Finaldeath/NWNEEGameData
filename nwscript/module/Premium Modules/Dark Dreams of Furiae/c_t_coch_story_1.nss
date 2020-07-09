// (If haven't finished Conversation 1 yet)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    if(GetLocalInt(oModule, "cochrane_story_index") > 0) return FALSE;

    return TRUE;
}
