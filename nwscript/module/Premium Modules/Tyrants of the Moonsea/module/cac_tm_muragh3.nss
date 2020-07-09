// player has given muragh all the ingredients so he is now making the golem

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("MuraghsMagnificentMachine", 20, oPC);
    PlotLevelSet("HighArtificerHlessen", 3);
}
