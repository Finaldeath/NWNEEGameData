//::///////////////////////////////////////////////
//:: ten_a1_trogfire
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Troglodyte has entered the trigger near the
    sacred fire, reactivate the fire.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "inc_trogfight"

void main()
{
    object oTrog = GetEnteringObject();

    if ((GetRacialType(oTrog) == RACIAL_TYPE_HUMANOID_REPTILIAN)
         && (GetIsPC(oTrog) == FALSE) && (GetTag(oTrog) != "a1_hench_garm")
         && (IsFireActive() == FALSE))
    {
        ActivateFire();
        ReviveTrogs();
    }
}
