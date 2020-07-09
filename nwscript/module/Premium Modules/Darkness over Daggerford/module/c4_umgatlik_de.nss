// umgatlik's death event; update journal and give XP

#include "hf_in_xp"

void main()
{
    object oPC = GetFirstPC();
    AddJournalQuestEntry("j80", 6, oPC);
    GiveQuestXPToCreature(oPC, "j80");
    SetLocalInt(GetModule(), "StrongholdQuest_cleric", 0);
}
