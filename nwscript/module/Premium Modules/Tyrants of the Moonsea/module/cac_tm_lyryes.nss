//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_lyryes
// DATE: February 16, 2006.
// AUTH: Luke Scull
// NOTE: Lyressa joins the party. Add journal entry.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "leavevoonlar", 1);
    AddJournalQuestEntry("HenchmenLyressa", 10, oPC);
    HenchmanHire(OBJECT_SELF, oPC);
}
