//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_b3
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: Returns true if the player:
//:: - Has the dragon tongue in inventory (fake or real)
//:: - But not yet delivered all three items
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_DRAGON_TONGUE_REAL = "tm_it_vaptongue0";
const string ITM_TAG_DRAGON_TONGUE_FAKE = "tm_it_vaptongue1";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oRealTongue = GetItemPossessedBy(oPC, ITM_TAG_DRAGON_TONGUE_REAL);
    object oFakeTongue = GetItemPossessedBy(oPC, ITM_TAG_DRAGON_TONGUE_FAKE);

    return ( (PlotLevelGet("biggamehunt_status_vapo") < 3) &&
             (PlotLevelCheckEquals("biggamehunt_status_main", 1)) &&
             (GetIsObjectValid(oFakeTongue) || GetIsObjectValid(oRealTongue)) );
}
