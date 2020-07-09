#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_guarded_warehouse_knowledge", TRUE);
    UpdateJournal(GetPCSpeaker());
}
