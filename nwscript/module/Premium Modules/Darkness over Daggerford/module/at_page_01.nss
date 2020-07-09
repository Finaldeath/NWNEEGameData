// the page leaves the castle and returns to griswald's tent

#include "hf_in_plot"
#include "inc_bw_worldmap"
#include "hf_in_cutscene"
#include "inc_stronghold"

void main()
{
    // update plot levels
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 1);

    // give journal quest
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j85", 1, oPC);
    SetLocalInt(GetModule(), "StrongholdQuest_fighter", 1);

    // griswald will now talk to you
    PlotLevelSet("ks_griswald", 1);

    // reveal world map icon
    RevealMapLocation("c1ar2000");

    // end the convo
    QuestMessengerFlee(oPC);
    CutsceneNextShot();
}
