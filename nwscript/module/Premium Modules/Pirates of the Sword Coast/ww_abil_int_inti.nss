//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Intimidate: Intimidate Check)
//:: WW_Abil_Int_Inti.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Intimidate: Intimidate" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_INTIMIDATE", oCreature, "WW_CHECK_TYPE_INTIMIDATE");
}
