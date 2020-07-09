//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Intimidate: Rage Check)
//:: WW_Abil_Int_Rage.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Intimidate: Rage" check
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_RAGE", oCreature, "WW_CHECK_TYPE_INTIMIDATE");
}
