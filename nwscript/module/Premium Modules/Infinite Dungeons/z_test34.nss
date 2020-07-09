#include "inc_id1_score"
#include "inc_id1_utility"

int StartingConditional()
{
    // if quest is not activated
    object oDungeon = GetCurrentDungeon();
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));
    int bActivated = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Activated");
    DebugMessage("bActivated is " + IntToString(bActivated));
    int bCompleted = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Completed");
    DebugMessage("bCompleted is " + IntToString(bCompleted));
    int bFailed = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Failed");
    DebugMessage("bFailed is " + IntToString(bFailed));

    // if player is not part of this persons quest
    object oPC = GetPCSpeaker();
    string sIdentifier = GetPCIdentifier(oPC);
    DebugMessage("sIdentifier is " + sIdentifier);
    int bMember = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Player_" + sIdentifier);

    if ((bActivated == FALSE) || ((bActivated == TRUE) && (bCompleted == FALSE) && (bFailed == FALSE) && (bMember == FALSE)))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
