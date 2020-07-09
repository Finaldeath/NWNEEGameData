//::///////////////////////////////////////////////
//:: cac_a1_trgshpb
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open the neutral Troglodyte store to the PC speaker.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a1_shp_trogs");
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
