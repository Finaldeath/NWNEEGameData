// player convinces griswald not to meet Feldran at midnight

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 2);
    PlotLevelSet("dt_ar2000_drawbridge", 3);
    AddJournalQuestEntry("j85", 5, oPC);
}
