// play the fowl druid's "remove curse" cutscene

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oStone = GetItemPossessedBy(oPC, "ks_it_bloodstn");
    DestroyObject(oStone);
    PlotLevelSet("ks_druid_gull", 8);
    SetLocalInt(GetModule(), "StrongholdQuest_druid", 0);
    CutscenePlay(oPC, "mv_ar1400_1");
}
