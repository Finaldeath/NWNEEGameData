#include "ddf_journal"

void main()
{
    // Set the flag that aladara is dead and update journal
    SetLocalInt(GetModule(), "ddf_karkualii_dead", TRUE);
    UpdateJournal(GetFirstPC());

    // Enable the worldwine pot
    object oPot = GetObjectByTag("FinalWorldwinePlot");
    SetUseableFlag(oPot, TRUE);
}
