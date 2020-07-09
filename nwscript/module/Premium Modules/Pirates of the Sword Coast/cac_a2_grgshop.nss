//::///////////////////////////////////////////////
//:: Act 2: Open Grogbeard Store
//:: cac_a2_grgshop
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Grog Beard's shop in the Monkey's
    Cutless.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a2_shp_tavern");
    object oPC = GetPCSpeaker();

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        if (GetLocalInt(oPC, "cac_a2_grgdeal") == TRUE)
        {
            //Good Prices
            gplotAppraiseOpenStore(oStore, GetPCSpeaker(), 0, 0);
        }
        else
        {
            //Neutral Prices
            gplotAppraiseOpenStore(oStore, oPC, 15, -15);
        }
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
