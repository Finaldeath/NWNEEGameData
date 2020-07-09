#include "ddf_journal"

void main()
{
    // Found out about Teddy via Quil's dialog 002
    SetLocalInt(GetModule(), "ddf_teddy_quil_002", TRUE);
    UpdateJournal(GetPCSpeaker());
}
