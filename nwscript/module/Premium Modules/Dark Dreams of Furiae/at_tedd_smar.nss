#include "ddf_journal"
// Sets flag that the player has spoken with Teddy at the Sea Market

void main()
{
    SetLocalInt(GetModule(), "ddf_tedd_smar", TRUE);
    UpdateJournal(GetPCSpeaker());
}
