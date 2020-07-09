// onDeath event for Elveronne in AR0701c
// .. update zombie quest journal entry when elveronne is dead

#include "hf_in_xp"

void main()
{
    // Set final journal entry for killing elveronne
    object oPC = GetFirstPC();
    AddJournalQuestEntry("j53", 5, oPC);
    SetLocalInt(oPC, "moris_quest", 4);

    // execute the standard death script
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
