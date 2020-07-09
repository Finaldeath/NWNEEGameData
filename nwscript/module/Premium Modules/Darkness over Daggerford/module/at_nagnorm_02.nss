// nagnorm gives penguin to player

#include "hf_in_plot"
#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oPenguin = GetNearestObjectByTag("ks_druid_peng", oPC);
    object oNagnorm = GetNearestObjectByTag("ks_nagnorm", oPC);

    // nagnorm has given away the bird
    PlotLevelSet("ks_nagnorm", 5);

    // nagnorm's key is now useless, so get rid of it
    object oKey = GetItemPossessedBy(oNagnorm, "ks_it_nagkey");
    DestroyObject(oKey);

    // penguin goes into inventory
    PlotLevelSet("ks_druid_peng", 2);
    CreateItemOnObject("a2_penguin", oPC, 1);
    DestroyObject(oPenguin);

    // end the cutscene
    CutsceneNextShot();
}
