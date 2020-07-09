//::///////////////////////////////////////////////
//:: Act 2: Open Vengaul/Honeypea Store
//:: cac_a2_nwnshop
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Vengaul/Honeypea's store.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a2_shp_nwgang");
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
