#include "hf_in_xp"
void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = GetNearestObjectByTag("db_astriel_lh", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    GiveQuestXPToCreature(oPC, "j201", 100.0);
    SetLocalInt(oPC, "HF_DO_AUTOSAVE", 1);
}
