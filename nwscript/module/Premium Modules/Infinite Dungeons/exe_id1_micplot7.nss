#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id1_gen"

void main()
{
    DebugMessage("");
    object oDungeon = GetCurrentDungeon();
    string sPlot = GetLocalString(OBJECT_SELF, "sPlot");
    int nArea = GetLocalInt(OBJECT_SELF, "nArea");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    DebugMessage("Revealing area " + IntToString(nArea) + " for " + sPlot + " on level is " + IntToString(nLevel));

    int nPlayerNum = GetLocalInt(oDungeon, "n" + sPlot + "PlayerNum");
    DebugMessage("  There are " + IntToString(nPlayerNum) + " players in this plot.");
    int nPlayer = 1;
    string sIdentifier;
    int nExplore;
    while (nPlayer <= nPlayerNum)
    {
        sIdentifier = GetLocalString(oDungeon, "s" + sPlot + "Player" + IntToString(nPlayer));
        DebugMessage("  Player " + IntToString(nPlayer) + " identifier is " + sIdentifier);
        nExplore = GetExploredState(OBJECT_INVALID, sIdentifier, nArea, nLevel, oDungeon);
        DebugMessage("    nPlayer_" + sIdentifier + "_Area" + IntToString(nArea) + "Level" + IntToString(nLevel) + "Explored is " + IntToString(nExplore));
        if (nExplore == 0)
        {
            SetExploredState(OBJECT_INVALID, sIdentifier, nArea, nLevel, 4, oDungeon);
        }

        nPlayer++;
    }

    DestroyObject(OBJECT_SELF);
}
