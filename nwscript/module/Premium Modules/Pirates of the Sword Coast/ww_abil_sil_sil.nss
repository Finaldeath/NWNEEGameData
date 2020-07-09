 //::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Silence: Silence Check)
//:: WW_Abil_Sil_Sil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Silence: Silence" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_SILENCE", oCreature, "WW_CHECK_TYPE_SILENCE");
}
