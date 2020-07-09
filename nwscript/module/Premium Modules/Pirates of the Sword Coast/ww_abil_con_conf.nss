//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Confuse: Cast Confusion Check)
//:: WW_Abil_Con_Conf.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Confuse:Cast Confusion" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_CONFUSION", oCreature, "WW_CHECK_TYPE_CONFUSE");
}
