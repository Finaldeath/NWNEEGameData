//::///////////////////////////////////////////////
//:: Act 2: Open Rogue Shop
//:: cac_a2_rgshop
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open the rogue shop in Spindrift
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a2_shp_thief");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        //Bad Prices
        gplotAppraiseOpenStore(oStore, GetPCSpeaker(), 30, -30);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
