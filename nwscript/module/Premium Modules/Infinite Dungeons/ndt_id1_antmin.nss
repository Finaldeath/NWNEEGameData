//::////////////////////////////////////////////////////////////////////////////
//:: ndt_id1_antmin
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Death Event script for Antoine's minons. As they minions die they are
    replaced.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 27, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_antoine"

void main()
{
    object oWP;
    int nRandomDelay = Random(5);
    int nTest = GetLocalInt(OBJECT_SELF, HUMAN_APPEARANCE_TYPE);

    if (nTest == -1) // If a boar has died.
    {
        // Only respawn if Antoine has not surrendered.

        if (!GetLocalInt(GetModule(), "bBacchaSurrender"))
        {
            int nRandomWP = Random(7) + 1;

            oWP = DB_GetWaypointByTag(RETREAT_WAYPOINT + IntToString(nRandomWP));

            DelayCommand(IntToFloat(nRandomDelay), CreateBoar(oWP));
        }
    }
    else // One of the were-creatures.
    {
        object oAntoine = DB_GetObjectByTag(ANTOINE_TAG);
        object oDungeon = GetCurrentDungeon();
        int nLevel = GetLocalInt(oDungeon, "nBossLevel");
        int nMinionsKilled = GetLocalInt(oAntoine, MINIONS_KILLED);

        // Only respawn if the player hasn't destroyed several already.
        if (nMinionsKilled < nLevel)
        {
            oWP = DB_GetNearestObjectByTag(MINION_RESPAWN);

            DelayCommand(IntToFloat(nRandomDelay), CreateWereBoar(oWP));

            nMinionsKilled++;
            SetLocalInt(oAntoine, MINIONS_KILLED, nMinionsKilled);
        }
    }

    // Default handling
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
