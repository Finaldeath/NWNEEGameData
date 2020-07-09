// player has found wanix, now needs to find urith

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j86", 4, oPC);
    PlotLevelSet("ks_druid_gull", 6);
}
