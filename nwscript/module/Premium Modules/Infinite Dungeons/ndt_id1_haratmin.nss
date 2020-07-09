//::////////////////////////////////////////////////////////////////////////////
//:: ndt_id1_haratmin
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Death Event script for Harat's minions.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 10, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

void main()
{
    object oThis = OBJECT_SELF;

    if (!GetLocalInt(GetModule(), "bHaratSurrender"))
    {
        object oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG);
        object oLever = GetLocalObject(oThis, GAURDED_LEVER);

        location lLoc = GetLocation(oWaypoint);
        float fDelay = IntToFloat(Random(50) + 20);
        int nCR = FloatToInt(GetChallengeRating(oThis));

        AssignCommand(oLever, DelayCommand(fDelay, CreateErinyesMinion(lLoc, nCR)));
    }

    // Default handling
    ExecuteScript("x2_def_ondeath", oThis);
}
