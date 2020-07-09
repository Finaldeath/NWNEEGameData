#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_wogbogs_stick", oPC, 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    if(PlotLevelGet("ks_wogbog") == 2)
    {
        AddJournalQuestEntry("j81", 2, oPC);
    }
}
