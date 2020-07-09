//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Pacify: Bard Song Check)
//:: WW_Abil_Pac_Song.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Pacify: Bard Song" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_BARD_SONG", oCreature, "WW_CHECK_TYPE_PACIFY");
}
