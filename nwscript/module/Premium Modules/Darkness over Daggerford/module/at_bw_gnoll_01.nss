#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetModule(), "nWH_OgresDispatched", 1);   // ogres no more
    AddJournalQuestEntry("j204", 17, oPC);
    GiveQuestXPToCreature(oPC, "j204", 100.0);
}
