//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Bluff: Dominate Person Check)
//:: WW_Abil_Blu_Domi.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Bluff: Dominate Person" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_DOMINATE_PERSON", oCreature, "WW_CHECK_TYPE_BLUFF");
}
