//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Consequence - Kill)
//:: WW_Abil_Cnq_Kill.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     The player kills the NPC before they could
     raise an alarm.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 15, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityConsequences("WW_CONSEQUENCE_KILL", oCreature);
}
