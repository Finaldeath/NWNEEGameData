// vetrixia gives the cleric stronghold quest

#include "hf_in_plot"
#include "inc_bw_worldmap"
#include "hf_in_cutscene"
#include "inc_stronghold"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    AddJournalQuestEntry("j80", 2, oPC);
    SetLocalInt(GetModule(), "StrongholdQuest_cleric", 1);
    SetLocalString(GetModule(), "UmgatlikCleric", GetTag(OBJECT_SELF));
    RevealMapLocation("c1ar2100");
    SetIsDestroyable(TRUE);
    QuestMessengerFlee(oPC);
    CutsceneNextShot();
}
