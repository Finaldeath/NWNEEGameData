// player kills gorlax: update quest status

#include "hf_in_plot"

void main()
{
    // advance the plot
    PlotLevelSet("Jackdaw", 2);
    PlotLevelSet("Sparrow", 7);
    AddJournalQuestEntry("GorlaxtheManyEyed", 60, GetFirstPC());

    // run the standard death events
    ExecuteScript("x2_def_ondeath", OBJECT_SELF);
}
