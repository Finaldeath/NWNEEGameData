#include "ddf_journal"

void main()
{
    // Set the flag that aladara is dead and update journal
    SetLocalInt(GetModule(), "ddf_aladara_dead", TRUE);
    UpdateJournal(GetFirstPC());
}
