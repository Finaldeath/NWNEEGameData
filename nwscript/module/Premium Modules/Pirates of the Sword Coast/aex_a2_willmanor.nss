//::///////////////////////////////////////////////
//:: aex_a2_willmanor
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Area OnExit script for Willigan's Manor.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 31, 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPCNotDM(oPC))
    {
        // PC's are immortal while in the area, but we need to reset the
        // flag when they exit the area.
        SetImmortal(oPC, FALSE);
    }
}
