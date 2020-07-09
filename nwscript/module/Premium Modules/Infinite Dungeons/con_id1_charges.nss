#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable"); // AreaXWaypointPuzzleYLevelZ
    int nCharges = GetLocalInt(oDungeon, "n" + sVariable + "ForgeCharges");
    if (nCharges > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
