//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Consequence - Paralyze)
//:: WW_Abil_Cnq_Para.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     The player temporarily paralyzes the NPC
     before they could raise an alarm.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 15, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityConsequences("WW_CONSEQUENCE_PARALYZE", oCreature);
}
