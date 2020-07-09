//::///////////////////////////////////////////////
//:: Act 0: Open Dela's Bloodsailor Store.
//:: cac_mbshstore
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Dela's store. This uses the XP2 appraise
    skill system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a0_shp_dela");
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
