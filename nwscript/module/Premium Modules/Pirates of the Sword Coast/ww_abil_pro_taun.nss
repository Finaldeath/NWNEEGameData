//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Provoke: Taunt Check)
//:: WW_Abil_Pro_Taun.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Provoke: Taunt" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_TAUNT", oCreature, "WW_CHECK_TYPE_PROVOKE");
}
