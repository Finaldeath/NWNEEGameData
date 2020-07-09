#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_harasi_notes_read", TRUE);
    UpdateJournal(GetFirstPC());
}
