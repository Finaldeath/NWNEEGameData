//::///////////////////////////////////////////////
//:: cac_a2_rdt_f2_2
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fight club: Sets the second fighter to
    Gretchen the Hun.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oFighter2 = GetObjectByTagInArea("a2_gretchen", GetArea(OBJECT_SELF));
    SetLocalObject(OBJECT_SELF, l_o_FIGHTCLUB_FIGHTER2, oFighter2);
}
