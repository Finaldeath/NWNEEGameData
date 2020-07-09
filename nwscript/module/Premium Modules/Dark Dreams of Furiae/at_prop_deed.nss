#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_property_deed", TRUE);
    UpdateJournal(GetPCSpeaker());
}
