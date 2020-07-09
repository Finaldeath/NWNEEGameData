//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Intimidate: Bestow Curse Check)
//:: WW_Abil_Int_Curs.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Intimidate: Bestow Curse" check
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_BESTOW_CURSE", oCreature, "WW_CHECK_TYPE_INTIMIDATE");
}
