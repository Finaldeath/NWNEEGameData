//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Confuse: Cast Bewilderment Check)
//:: WW_Abil_Con_Bewi.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Confuse: Cast Bewilderment" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_BEWILDERMENT", oCreature, "WW_CHECK_TYPE_CONFUSE");
}
