//::///////////////////////////////////////////////
//:: aen_a2_willstudy
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Area on enter script for Willigan's Study.

    If the entering player has a henchman
    array, then try re-adding them back to the
    player's party.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 30, 2005
//:://////////////////////////////////////////////
#include "inc_willigan"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPCNotDM(oPC))
    {
        A2WillyRestoreHenchmen(oPC);
    }
}
