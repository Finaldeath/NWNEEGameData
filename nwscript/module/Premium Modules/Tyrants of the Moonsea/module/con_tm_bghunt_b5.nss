//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_b5
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: Returns true if the player:
//:: - Has the render head in inventory
//:: - But not yet delivered all three items
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_RENDER_HEAD = "tm_it_renderhea";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHead = GetItemPossessedBy(oPC, ITM_TAG_RENDER_HEAD);

    return (PlotLevelCheckEquals("biggamehunt_status_main", 1) &&
            GetIsObjectValid(oHead));
}
