#include "inc_id1_score"

void main()
{
    DebugMessage("");
    DebugMessage("Unlocking door script.");


    // award points
    object oPC = GetLastUnlocked();
    if (GetIsPC(oPC) == FALSE)
    {
        oPC = GetMaster(oPC);
    }
    if (GetIsPC(oPC) == TRUE)
    {
        // get waypoint number off door
        int nWaypoint = GetLocalInt(OBJECT_SELF, "nNumber");
        DebugMessage("  Waypoint is number " + IntToString(nWaypoint) + " in this area.");

        // get area identifier
        int nAreaIdentifier = GetLocalInt(GetArea(OBJECT_SELF), "nAreaIdentifier");
        DebugMessage("  Area is identifier " + IntToString(nAreaIdentifier));

        // get current dungeon
        object oDungeon = GetCurrentDungeon();

        // get area number
        int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
        DebugMessage("  Area is dungeon area number " + IntToString(nAreaNum));

        // get current level
        int nLevel = GetLocalInt(GetModule(), "nCurrentLevel");
        DebugMessage("  Current dungeon level is " + IntToString(nLevel));

        // get waypoint variable in area
        string sLevel = "Area" + IntToString(nAreaNum) + "GenericDoor" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  Waypoint variable is " + sLevel);

        // set the door as having been disarmed
        DebugMessage("  Door marked as unlocked.");
        SetLocalInt(oDungeon, "b" + sLevel + "Unlocked", TRUE);

        int nDC = GetLockUnlockDC(OBJECT_SELF);

        AwardLockPickedPoints(oPC, nDC);
    }
}