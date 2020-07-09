//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Pacify: Prayer Check)
//:: WW_Abil_Pac_Pray.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Pacify: Prayer" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_PRAYER", oCreature, "WW_CHECK_TYPE_PACIFY");
}
