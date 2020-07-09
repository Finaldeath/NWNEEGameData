////////////////////////////////////////////////////////////////////////////////
// dla_atsellenable - Test to see if horse selling is enabled and if the PC has
// any horses for sell.
// Scripted By: Deva B. Winblood   8/03/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"


int StartingConditional()
{
    int bHasHorse=FALSE;
    object oOb;
    int nN;
    if (GetLocalInt(GetModule(),"bNoSellHorses")) return FALSE;
    if (DLA_GetIsMounted(GetPCSpeaker())) return TRUE;
    nN=1;
    oOb=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker(),nN);
    while(GetIsObjectValid(oOb))
    { // check for horses
        if (DLA_GetIsMounted(oOb)||DLA_GetIsDLAHorse(oOb)) return TRUE;
        nN++;
        oOb=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker(),nN);
    } // check for horses
    return FALSE;
}
