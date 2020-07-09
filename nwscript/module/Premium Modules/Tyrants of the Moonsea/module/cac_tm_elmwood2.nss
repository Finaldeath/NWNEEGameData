//Enrad reveals to PC that Elanawen was seeing Ezril
#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    AddJournalQuestEntry("MurderInElmwood", 30, GetPCSpeaker());
}
