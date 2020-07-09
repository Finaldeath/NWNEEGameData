#include "ddf_journal"

void main()
{
    // Remove the blocker
    object oBlocker = GetObjectByTag("RecordsBlocker");
    DestroyObject(oBlocker);

    SetLocalInt(GetModule(), "ddf_guvner_gain_entrance", TRUE);
    UpdateJournal(GetPCSpeaker());
}
