//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_thayanam1
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: PC has at least one ceremony pass
//::////////////////////////////////////////////////////

#include "nw_i0_plot"

const string ITM_TAG_CEREMONY_PASS = "tm_it_ceremonyp0";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nNumPasses = GetNumItems(oPC, ITM_TAG_CEREMONY_PASS);

    return ((nNumPasses >= 1));
}
