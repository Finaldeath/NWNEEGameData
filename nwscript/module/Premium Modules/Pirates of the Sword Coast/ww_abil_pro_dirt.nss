//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Provoke: Dirty Fighting Check)
//:: WW_Abil_Pro_Dirt.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Provoke: Dirty Fighting" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_DIRTY_FIGHTING", oCreature, "WW_CHECK_TYPE_PROVOKE");
}
