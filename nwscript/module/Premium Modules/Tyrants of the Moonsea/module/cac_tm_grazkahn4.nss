//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn4
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Update journal, player has agreed to retrieve
//       Kazz's sword. Note that this differs from
//       cac_tm_grazkahn1 in that the player has spoken
//       to Grazkahn first rather than initially helping
//       Kazz.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("FiendsAtWar", 33, oPC, TRUE, FALSE, TRUE);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
}
