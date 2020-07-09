//::///////////////////////////////////////////////
//:: Act 2: Open the Turf War Store
//:: cac_a0_brbstore
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open the Turf War store (used by both the
    Bloodsailors and the Blackriver Bandits).
    This uses the XP2 appraise skill system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a0_shp_honey");
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
