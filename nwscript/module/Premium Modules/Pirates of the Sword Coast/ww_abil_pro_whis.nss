//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Provoke: Wounding Whispers Check)
//:: WW_Abil_Pro_Whis.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Provoke: Wounding Whispers" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_WOUNDING_WHISPERS", oCreature, "WW_CHECK_TYPE_PROVOKE");
}
