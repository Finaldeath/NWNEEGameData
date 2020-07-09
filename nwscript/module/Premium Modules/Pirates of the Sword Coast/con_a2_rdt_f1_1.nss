//::///////////////////////////////////////////////
//:: con_a2_rdt_f1_1
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fight club: Is the first fighter NOT
    Scurvy Johnson?
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////
#include "inc_global"

int StartingConditional()
{
    object oFighter1 = GetObjectByTagInArea("a2_scurvy", GetArea(OBJECT_SELF));
    return (oFighter1 != GetLocalObject(OBJECT_SELF, l_o_FIGHTCLUB_FIGHTER1));
}
