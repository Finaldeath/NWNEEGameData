#include "inc_id1_score"
#include "inc_id1_utility"

int StartingConditional()
{
    // if quest is completed
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    object oDungeon = GetCurrentDungeon();
    int bCompleted = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Completed");

    if (bCompleted == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
