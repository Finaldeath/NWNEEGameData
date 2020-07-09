// the druid chicken has given the quest to the player

#include "hf_in_plot"
#include "inc_bw_worldmap"

void main()
{
    // give the quest
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j86", 1, oPC);
    SetLocalInt(GetModule(), "StrongholdQuest_druid", 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    RevealMapLocation("c1ar1400");
}
