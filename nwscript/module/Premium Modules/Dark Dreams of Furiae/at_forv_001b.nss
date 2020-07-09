// (finished conversation 2, journal updated)

#include "ddf_util"
#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "forvor_story_index", 2);
    UpdateJournal(GetPCSpeaker());
}
