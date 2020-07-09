//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Consequence - Silence)
//:: WW_Abil_Cnq_Sil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     The player temporarily silences the NPC
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
    WW_DoAbilityConsequences("WW_CONSEQUENCE_SILENCE", oCreature);
}
