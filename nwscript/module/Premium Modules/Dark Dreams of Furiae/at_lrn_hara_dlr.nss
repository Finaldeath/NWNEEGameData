#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_learn_harasi_dealers", TRUE);
    UpdateJournal(GetPCSpeaker());
}
