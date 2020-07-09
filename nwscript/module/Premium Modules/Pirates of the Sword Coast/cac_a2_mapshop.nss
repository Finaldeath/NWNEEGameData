//::///////////////////////////////////////////////
//:: Act 2: Open Map Store
//:: cac_a2_mapshop
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open the map shop in Spindrift
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a2_shp_maps");
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
