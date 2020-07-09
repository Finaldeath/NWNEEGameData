// deldarine gives the quest to find edalseye

#include "hf_in_plot"
#include "inc_bw_worldmap"
#include "hf_in_cutscene"
#include "inc_stronghold"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("ks_deldarine", 1);
    AddJournalQuestEntry("j83", 1, oPC);
    SetLocalInt(GetModule(), "StrongholdQuest_mage", 1);
    RevealMapLocation("c1ar1100");
    QuestMessengerFlee(oPC);
    CutsceneNextShot();
}
