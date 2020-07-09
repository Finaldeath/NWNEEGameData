//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Pacify: Animal Empathy Check)
//:: WW_Abil_Pac_Empa.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Pacify: Animal Empathy" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_ANIMAL_EMPATHY", oCreature, "WW_CHECK_TYPE_PACIFY");
}
