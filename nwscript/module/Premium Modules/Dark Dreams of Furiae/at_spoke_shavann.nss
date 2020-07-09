#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_spoke_with_shavann", TRUE);
    UpdateJournal(GetPCSpeaker());

}
