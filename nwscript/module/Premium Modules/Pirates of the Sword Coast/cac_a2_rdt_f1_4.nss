//::///////////////////////////////////////////////
//:: cac_a2_rdt_f1_4
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fight club: Sets the first fighter to
    dire wolf.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oFighter1 = GetObjectByTagInArea("NW_DIREWOLF", GetArea(OBJECT_SELF));
    SetLocalObject(OBJECT_SELF, l_o_FIGHTCLUB_FIGHTER1, oFighter1);
}
