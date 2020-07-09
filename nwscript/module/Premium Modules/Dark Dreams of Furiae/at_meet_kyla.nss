#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_meet_kyla", TRUE);
    UpdateJournal(GetPCSpeaker());
}
