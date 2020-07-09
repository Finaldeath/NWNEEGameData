//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Confuse: Intelligence Check)
//:: WW_Abil_Con_Int.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Confuse: Intelligence" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_INTELLIGENCE", oCreature, "WW_CHECK_TYPE_CONFUSE");
}
