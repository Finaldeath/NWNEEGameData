//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_craster1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Add The Elven Hamlet journal entry and set
//       int so Craster's dialogue updates.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("TheElvenHamlet", 10, oPC);
    SetLocalInt(oPC, "crasterspoke", 1);
    PlotLevelSet("Craster", 2);
}
