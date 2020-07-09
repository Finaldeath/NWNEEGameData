#include "inc_id1_debug"

void main()
{
    SetLocalInt(OBJECT_SELF, "nQuestLogDisplay", 1);
    SetLocalInt(OBJECT_SELF, "nQuestLogOffset", 0);
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotTotal");
    SetLocalInt(OBJECT_SELF, "nPlotTypeNum", nPlotTypeNum);
    DebugMessage("Looking at all quests. There are " + IntToString(nPlotTypeNum));
}
