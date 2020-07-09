//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_kazz1
// DATE: November 1, 2005
// AUTH: Luke Scull
// NOTE: Adds Fiends At War journal entry. Player
//       has agreed to kill Grazkahn.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 3);
    if(PlotLevelGet("Grazkahn") == 2)
    {
        AddJournalQuestEntry("FiendsAtWar", 15, oPC, TRUE, FALSE, TRUE);
    }
    else
    {
        AddJournalQuestEntry("FiendsAtWar", 10, oPC, TRUE, FALSE, TRUE);
    }
}
