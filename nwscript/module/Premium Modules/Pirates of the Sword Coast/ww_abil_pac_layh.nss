//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Pacify: Lay Hands Check)
//:: WW_Abil_Pac_LayH.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Pacify: Lay Hands" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_LAY_HANDS", oCreature, "WW_CHECK_TYPE_PACIFY");
}
