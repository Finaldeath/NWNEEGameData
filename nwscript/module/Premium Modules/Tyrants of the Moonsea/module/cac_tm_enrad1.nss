#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    AddJournalQuestEntry("MurderInElmwood", 10, GetPCSpeaker());
}
