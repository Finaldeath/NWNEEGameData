//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: on_tm_thayanam2
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: Party size > 1 and 2 ceremony passes
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"
#include "nw_i0_plot"


const string ITM_TAG_CEREMONY_PASS = "tm_it_ceremonyp0";


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nNumPasses = GetNumItems(oPC, ITM_TAG_CEREMONY_PASS);
    int nPartySize = HenchmanCount(oPC)+1; // +1 for PC

    return ((nPartySize > 1) && (nNumPasses > 1));
}