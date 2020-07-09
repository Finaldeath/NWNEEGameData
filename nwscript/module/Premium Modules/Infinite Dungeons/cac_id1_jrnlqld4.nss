#include "inc_id1_debug"

void main()
{
    SetLocalInt(OBJECT_SELF, "nQuestLogDisplay", 4);
    SetLocalInt(OBJECT_SELF, "nQuestLogOffset", 0);
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotFailed");
    SetLocalInt(OBJECT_SELF, "nPlotTypeNum", nPlotTypeNum);
    DebugMessage("Looking at failed quests. There are " + IntToString(nPlotTypeNum));
}
