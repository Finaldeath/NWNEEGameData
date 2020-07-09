//::///////////////////////////////////////////////
//:: aen_a2_sndspt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has entered the Sandy Spit
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "inc_global"

void main()
{
    object oEnteringObject = GetEnteringObject();
    cs_AreaOnEnter_Poly(oEnteringObject);

    if (GetIsPCNotDM(oEnteringObject) == TRUE)
    {
        UpdateSafePoint();
    }
}
