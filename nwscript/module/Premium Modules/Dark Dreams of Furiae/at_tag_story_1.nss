// (finished Conversation 1, journal updated)

#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    SetLocalInt(oModule, "tag_story_index", 1);
    UpdateJournal(oPC);

}
