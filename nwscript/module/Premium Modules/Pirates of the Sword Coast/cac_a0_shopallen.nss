//::///////////////////////////////////////////////
//:: Act 0: Open Allendry's Store
//:: cac_a0_shopallen.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Allendry's store (non-cutscene variant).
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 21, 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a0_shp_allendry");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        //Good Prices
        gplotAppraiseOpenStore(oStore, GetPCSpeaker(), 0, 0);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}

