// (finished conversation 1, journal updated)
#include "ddf_util"
#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "kresh_story_index", 1);
    UpdateJournal(GetPCSpeaker());
}
