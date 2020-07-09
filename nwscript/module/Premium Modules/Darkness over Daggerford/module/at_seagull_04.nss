// player has found all 4 fowls

#include "hf_in_plot"
#include "inc_bw_worldmap"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j86", 5, oPC);
    PlotLevelSet("ks_druid_gull", 7);
    RevealMapLocation("c1ar0900");
}
