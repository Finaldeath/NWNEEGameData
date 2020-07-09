//::///////////////////////////////////////////////
//:: dd_dth_ondeath
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Custom death script for followers
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "inc_respawn"

void main()
{
    object oDead = OBJECT_SELF;
    object oCursor = OBJECT_INVALID;

    // notify all players of the followers death
    oCursor = GetFirstPC();
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        FloatingTextStringOnCreature("Crewman " + GetName(oDead)
            + " has fallen and needs to be rescued!", oCursor, TRUE);

        oCursor = GetNextPC();
    }

    // Mark the location at while they fell and
    // wait for a revival opportunity.
    DeadMarker(oDead);
    DelayCommand(10.0f, CheckTargetSafeState(oDead, oDead));

    //ExecuteScript("nw_c2_default7", oDead);
}

