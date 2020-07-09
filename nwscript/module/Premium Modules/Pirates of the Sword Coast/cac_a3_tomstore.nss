//::///////////////////////////////////////////////
//:: Act 3: Open Gullym's Store
//:: cac_a3_tomstore.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Gullym's store. This uses the XP2 appraise
    skill system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a3_shp_gullym");

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
