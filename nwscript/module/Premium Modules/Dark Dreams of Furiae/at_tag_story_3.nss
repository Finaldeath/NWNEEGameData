// (finished Conversation 3, journal updated)

#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    SetLocalInt(oModule, "tag_story_index", 3);
    UpdateJournal(oPC);

}
