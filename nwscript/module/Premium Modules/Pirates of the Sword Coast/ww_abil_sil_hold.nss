//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Silence: Hold Person Check)
//:: WW_Abil_Sil_Hold.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Silence: Hold Person" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_HOLD_PERSON", oCreature, "WW_CHECK_TYPE_SILENCE");
}
