//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Intimidate: Fear Check)
//:: WW_Abil_Int_Fear.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Intimidate: Fear" check
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_FEAR", oCreature, "WW_CHECK_TYPE_INTIMIDATE");
}
