//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_astaryes
// DATE: November 20, 2005.
// AUTH: Luke Scull
// NOTE: Astar joins the party. Add journal entry.
//       Edit: Also remove cutscene mode and set int
//       so trigger doesn't fire again.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    HenchmanHire(OBJECT_SELF, oPC);
    AddJournalQuestEntry("HenchmenAstar", 10, GetPCSpeaker());
    SetLocalInt(oPC, "astartrigger", 2);
    SetCutsceneMode(oPC, FALSE);
}
