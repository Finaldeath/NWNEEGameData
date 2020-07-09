//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Obtain Favor: Persuade Check)
//:: WW_Abil_Fav_Pers.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Obtain Favor: Persuade" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_PERSUADE", oCreature, "WW_CHECK_TYPE_OBTAIN_FAVOR");
}
