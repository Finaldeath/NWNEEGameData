//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Pacify: Remove Fear Check)
//:: WW_Abil_Pac_Remo.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Pacify: Remove Fear" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_REMOVE_FEAR", oCreature, "WW_CHECK_TYPE_PACIFY");
}
