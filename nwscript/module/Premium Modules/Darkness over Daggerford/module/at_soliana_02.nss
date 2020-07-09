// soliana is waiting for griswald to rescue here

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j85", 8, oPC);
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 1);
}
