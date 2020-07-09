//::////////////////////////////////////////////////////////////////////////////
//:: pun_id1_cont
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Un Lock event for containers. When a lock is pick the lock picker should
    be award some points in the score keeping system.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 2, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_score"

void main()
{
    // award points
    object oPC = GetLastUnlocked();
    if (GetIsPC(oPC) == FALSE)
    {
        oPC = GetMaster(oPC);
    }
    if (GetIsPC(oPC) == TRUE)
    {
        object oContainer = OBJECT_SELF;
        object oDungeon = GetCurrentDungeon();

        // Establish the dungeon variable identifier for the container.
        string sVariable = GetLocalString(oContainer, "sVariable");
        DebugMessage("Treasure chest with sVariable as " + sVariable + " was unlocked.");

        SetLocalInt(oDungeon, "b" + sVariable + "Unlocked", TRUE);

        int nDC = GetLockUnlockDC(OBJECT_SELF);

        AwardLockPickedPoints(oPC, nDC);
    }
}
