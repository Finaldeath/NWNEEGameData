//::///////////////////////////////////////////////
//:: aen_a3_mrblwdck
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Update the safe waypoint when you reach the
    midnight rose in the third act.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "_inc_generic"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPCNotDM(oPC) == TRUE)
    {
        UpdateSafePoint();
    }
}
