#include "hf_in_plot"

void main()
{
    PlotLevelSet("TheCrippledFangDead", 1);
    AddJournalQuestEntry("OrderoftheCrippledFang", 38, GetFirstPC());
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
