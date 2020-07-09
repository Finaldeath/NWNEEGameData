//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Silence: Dexterity Check)
//:: WW_Abil_Sil_Dex.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Silence: Dexterity" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_DEXTERITY", oCreature, "WW_CHECK_TYPE_SILENCE");
}

