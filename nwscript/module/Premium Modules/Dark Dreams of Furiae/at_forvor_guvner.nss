#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_fovor_guvners", TRUE);
    UpdateJournal(GetPCSpeaker());
}
