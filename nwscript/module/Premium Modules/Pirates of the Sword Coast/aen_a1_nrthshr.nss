//::///////////////////////////////////////////////
//:: aen_a1_nrthshr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A player object has entered the North Shore
    of the Troglodyte Island. Do a single player
    autosave.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oEnter = GetEnteringObject();

    cs_AreaOnEnter_Poly(oEnter);

    if (GetIsPCNotDM(oEnter))
    {
        ExecuteScript("exe_autosave", GetModule());
    }
}
