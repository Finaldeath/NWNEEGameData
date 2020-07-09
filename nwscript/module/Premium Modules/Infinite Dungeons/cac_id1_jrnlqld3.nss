#include "inc_id1_debug"

void main()
{
    SetLocalInt(OBJECT_SELF, "nQuestLogDisplay", 3);
    SetLocalInt(OBJECT_SELF, "nQuestLogOffset", 0);
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotCompleted");
    SetLocalInt(OBJECT_SELF, "nPlotTypeNum", nPlotTypeNum);
    DebugMessage("Looking at completed quests. There are " + IntToString(nPlotTypeNum));
}
