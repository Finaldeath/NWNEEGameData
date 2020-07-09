//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Intimidate: Divine Wrath Check)
//:: WW_Abil_Int_Wrat.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Intimidate: Divine Wrath" check
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_DIVINE_WRATH", oCreature, "WW_CHECK_TYPE_INTIMIDATE");
}
