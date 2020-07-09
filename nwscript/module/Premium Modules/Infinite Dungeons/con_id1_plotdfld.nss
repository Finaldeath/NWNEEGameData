#include "inc_id1_score"
#include "inc_id1_utility"

int StartingConditional()
{
    // if quest is failed
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    object oDungeon = GetCurrentDungeon();
    int bFailed = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Failed");

    if (bFailed == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
