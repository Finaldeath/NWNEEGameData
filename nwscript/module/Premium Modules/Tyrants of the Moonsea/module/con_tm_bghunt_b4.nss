//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_b4
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: Returns true if the player:
//:: - Has the werebear pelt in inventory (fake or real)
//:: - But not yet delivered all three items
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_WEREBEAR_PELT = "tm_it_karimpelt0";
const string ITM_TAG_WEREBEAR_PELT_FAKE = "tm_it_karimpelt1";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oRealPelt = GetItemPossessedBy(oPC, ITM_TAG_WEREBEAR_PELT);
    object oFakePelt = GetItemPossessedBy(oPC, ITM_TAG_WEREBEAR_PELT_FAKE);

    return ( (PlotLevelGet("biggamehunt_status_were") < 3) &&
             (PlotLevelCheckEquals("biggamehunt_status_main", 1)) &&
             (GetIsObjectValid(oRealPelt) || GetIsObjectValid(oFakePelt)) );
}
