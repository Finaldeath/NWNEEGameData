#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "nWH_PaidToll", 100);   // paid toll
    AddJournalQuestEntry("j204", 13, oPC);
    GiveQuestXPToCreature(oPC, "j204", 50.0);
}
