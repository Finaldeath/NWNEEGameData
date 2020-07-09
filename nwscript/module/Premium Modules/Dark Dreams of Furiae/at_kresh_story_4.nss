// (finished conversation 4, journal updated, xp)
#include "ddf_util"
#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "kresh_story_index", 4);
    //GiveXPToAll(GetPCSpeaker(), XP_MEDIUM);
    UpdateJournal(GetPCSpeaker());
}
