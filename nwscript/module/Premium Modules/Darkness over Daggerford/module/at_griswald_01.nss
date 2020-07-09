// griswald has spoken with the player

#include "hf_in_plot"

void main()
{
    // knights will now talk to you
    PlotLevelSet("ks_gris_knight", 1);

    // drawbridge will now talk with you
    PlotLevelSet("dt_ar2000_drawbridge", 1);

    // update journal
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j85", 2, oPC);

    // advance Griswald's plot
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 2);
}
