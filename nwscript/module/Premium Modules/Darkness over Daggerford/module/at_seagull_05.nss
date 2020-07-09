// player has found urith, now needs to find wanix

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j86", 3, oPC);
    PlotLevelSet("ks_druid_gull", 4);
}
