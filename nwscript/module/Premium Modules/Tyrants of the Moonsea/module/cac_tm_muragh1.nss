// sidequest: muragh's magnificent machine
// player has agreed to look for components

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("MuraghsMagnificentMachine", 10, oPC);
    PlotLevelSet("HighArtificerHlessen", 2);
}
