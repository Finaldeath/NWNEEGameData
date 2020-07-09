//::///////////////////////////////////////////////
//:: Act 1: Open Edgrimm's Store
//:: cac_a1_edshop1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Edgrimms store. This uses the XP2
    appraise skill system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oStore = GetObjectByTag("a1_shp_edgrimm");
    int bFavor = GetLocalInt(oPC, "A1_EDGRIMMFAVOR");
    //Default to Neutral Prices
    int nMarkUp = 15;
    int nMarkDown = -15;

    //If player obtained a favor from Edgrimm, improve the prices to Good.
    if (bFavor == TRUE)
    {
        nMarkUp = 0;
        nMarkDown = 0;
    }

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, oPC, nMarkUp, nMarkDown);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
