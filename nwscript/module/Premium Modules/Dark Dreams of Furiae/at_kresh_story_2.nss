// (finished conversation 2, journal updated)
#include "ddf_util"
#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "kresh_story_index", 2);
    UpdateJournal(GetPCSpeaker());
}
