//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn1
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Update journal; player has agreed to retrieve
//       Kazz's sword.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 2);

    if(PlotLevelGet("KazzTemmet") == 3)
    {
        AddJournalQuestEntry("FiendsAtWar", 15, oPC, TRUE, FALSE, TRUE);
    }
    else
    {
        AddJournalQuestEntry("FiendsAtWar", 20, oPC, TRUE, FALSE, TRUE);
    }
}
