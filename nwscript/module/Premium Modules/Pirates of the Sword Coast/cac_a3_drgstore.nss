//::///////////////////////////////////////////////
//:: Act 3: Open Bronze Dragon's Store
//:: cac_a3_drgstore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Yxondralu's store.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a3_shp_dragon");

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        //Neutral Prices
        gplotAppraiseOpenStore(oStore, GetPCSpeaker(), 15, -15);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
