//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Provoke: Wisdom Check)
//:: WW_Abil_Pro_Wis.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Provoke: Wisdom" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_WISDOM", oCreature, "WW_CHECK_TYPE_PROVOKE");
}
