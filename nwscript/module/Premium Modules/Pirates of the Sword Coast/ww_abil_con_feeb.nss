//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Confuse: Cast Feeblemind Check)
//:: WW_Abil_Con_Feeb.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Confuse: Cast Feeblemind" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_FEEBLEMIND", oCreature, "WW_CHECK_TYPE_CONFUSE");
}
