// igaleus gives the player the quest to free the slaves

#include "hf_in_plot"

void main()
{
    // update my plot
    string sTag = GetTag(OBJECT_SELF);
    PlotLevelSet(sTag, 1);

    // give the quest
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j89", 1, oPC);
}
