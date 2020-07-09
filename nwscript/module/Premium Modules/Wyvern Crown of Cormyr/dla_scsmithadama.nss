/*
    DLA_SCSMITHADAMA.nss
    B W-Husey
    Generic conditional. PC has enough gold to craft with adamantium.
*/

#include "nw_i0_tool"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nSpec;
    if (GetLocalInt(oPC,"nCostAd")==1) nSpec = 500;
    // Make sure the PC speaker has these items in their inventory
    if(GetGold(oPC) < ((GetLocalInt(OBJECT_SELF,"nCost"))*5 - nSpec))
        return FALSE;

    return TRUE;
}


