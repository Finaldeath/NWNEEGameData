#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_lone_guard_001", TRUE);
    UpdateJournal(GetPCSpeaker());
}
