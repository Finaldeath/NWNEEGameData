#include "inc_id1_debug"

void main()
{
    SetLocalInt(OBJECT_SELF, "nQuestLogDisplay", 2);
    SetLocalInt(OBJECT_SELF, "nQuestLogOffset", 0);
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotActivated");
    SetLocalInt(OBJECT_SELF, "nPlotTypeNum", nPlotTypeNum);
    DebugMessage("Looking at activated quests. There are " + IntToString(nPlotTypeNum));
}
