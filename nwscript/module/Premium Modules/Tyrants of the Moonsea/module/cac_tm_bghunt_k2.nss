//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_k2
//:: DATE: January 13, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Karim Ninetrees
//:: Shows Karim the bear pelt.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_BEAR_PELT = "tm_it_bearpelt0";
const string ITM_TAG_WEREBEAR_PELT_FAKE = "tm_it_karimpelt1";

void main()
{
    object oPC = GetPCSpeaker();
    object oBearPelt = GetItemPossessedBy(oPC, ITM_TAG_BEAR_PELT);

    if (GetIsObjectValid(oBearPelt))
    {
        PlotLevelSet("biggamehunt_status_were", 2);
        AddJournalQuestEntry("BigGameHunt-Werebear", 40, oPC);

        DestroyObject(oBearPelt);
        CreateItemOnObject(ITM_TAG_WEREBEAR_PELT_FAKE, oPC, 1);
    }
}
