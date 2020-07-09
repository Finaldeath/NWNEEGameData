//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_eremyes
// DATE: February 16, 2006.
// AUTH: Luke Scull
// NOTE: Eremuth joins the party. Add journal entry.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    HenchmanHire(OBJECT_SELF, oPC);
    AddJournalQuestEntry("HenchmenEremuth", 10, oPC);
    SetLocalInt(oPC, "eremuthtrigger", 2);
    SetCutsceneMode(oPC, FALSE);
}
