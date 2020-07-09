//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Consequence - Alarm)
//:: WW_Abil_Cnq_Alrm.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     An alarm is raised. This fires User-Defined
     Event #1701 on the area, allowing for custom
     behavior.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 15, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    WW_DoAbilityConsequences("WW_CONSEQUENCE_ALARM", OBJECT_INVALID);
}
