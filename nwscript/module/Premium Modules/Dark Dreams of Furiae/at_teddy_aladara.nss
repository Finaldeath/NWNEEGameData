#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_teddy_aladara", TRUE);
    GiveXPToCreature(GetPCSpeaker(), 50);
    UpdateJournal(GetPCSpeaker());
}
