#include "inc_id1_score"

void main()
{
    // award points
    object oPC = GetLastDisarmed();
    if (GetIsPC(oPC) == FALSE)
    {
        oPC = GetMaster(oPC);
    }
    if (GetIsPC(oPC) == TRUE)
    {
        // get current dungeon
        object oDungeon = GetCurrentDungeon();

        // get waypoint variable in area
        string sLevel = GetLocalString(OBJECT_SELF, "sVariable");
        DebugMessage("  Waypoint variable is " + sLevel);

        // set the door as having been disarmed
        DebugMessage("  Trap disarmed on door.");
        SetLocalInt(oDungeon, "b" + sLevel + "Triggered", TRUE);

        int nDC = GetTrapDisarmDC(OBJECT_SELF);

        AwardTrapDisarmedPoints(oPC, nDC);
    }
}
