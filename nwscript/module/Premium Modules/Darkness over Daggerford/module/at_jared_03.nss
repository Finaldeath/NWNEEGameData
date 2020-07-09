// jared gives the cleric stronghold quest to the player

#include "hf_in_plot"
#include "inc_bw_worldmap"
#include "hf_in_cutscene"
#include "inc_stronghold"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    AddJournalQuestEntry("j80", 1, oPC);
    SetLocalInt(GetModule(), "StrongholdQuest_cleric", 1);
    SetLocalString(GetModule(), "UmgatlikCleric", GetTag(OBJECT_SELF));
    RevealMapLocation("c1ar2100");
    QuestMessengerFlee(oPC);
    CutsceneNextShot();
}
