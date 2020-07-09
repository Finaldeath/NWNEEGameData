//::///////////////////////////////////////////////
//:: Act 2: Open Prugdush's Weapon Shop
//:: cac_a2_wpnsho.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open the Weapon shop in the Prugdush's world
    of weapons.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a2_shp_smith");
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
