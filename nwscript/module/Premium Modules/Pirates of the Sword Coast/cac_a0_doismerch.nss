//::///////////////////////////////////////////////
//:: Act 0: Open Doisin's Store (Silver Sails)
//:: cac_a0_doismerch
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open Doisin's Silver Sails store. This uses
    the XP2 appraise skill system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oStore = GetObjectByTag("a0_shp_doisin");
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
