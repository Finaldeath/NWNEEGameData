//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Obtain Favor: Charm Person Check)
//:: WW_Abil_Fav_Char.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Obtain Favor: Charm Person" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_CHARM_PERSON", oCreature, "WW_CHECK_TYPE_OBTAIN_FAVOR");
}
