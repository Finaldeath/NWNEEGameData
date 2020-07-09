#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    object oBones = GetItemPossessedBy(oPC, "ks_dig_bone");
    DestroyObject(oBones);
    CutscenePlay(oPC, "mv_ar2104_2");
}
