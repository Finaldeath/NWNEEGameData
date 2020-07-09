//::///////////////////////////////////////////////
//:: aex_nopolymorph
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes polymorph from all PC's who are
    exiting the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: May 4, 2005
//:://////////////////////////////////////////////
#include "inc_polymorphfix"

void main()
{
    object oPC = GetExitingObject();
    if(GetIsPCNotDM(oPC))
    {
        RemovePolymorph(oPC);
    }
}
