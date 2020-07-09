// player wrote a message to hester and takes wolly

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("ks_hester", 2);
    PlotLevelSet("ks_druid_parrot", 2);

    // the paper has served its purpose so destroy it
    object oPaper = GetItemPossessedBy(oPC, "ks_it_paper");
    DestroyObject(oPaper);

    // pick-up wolly
    object oParrot = GetNearestObjectByTag("ks_druid_parrot", oPC);
    DestroyObject(oParrot);
    CreateItemOnObject("a2_parrot", oPC, 1);
}
