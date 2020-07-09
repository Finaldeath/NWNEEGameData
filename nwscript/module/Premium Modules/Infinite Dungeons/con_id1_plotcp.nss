#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_score"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    DebugMessage("sVariable is " + sVariable);
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));

    string sPlot = "Plot" + IntToString(nPlot);
    DebugMessage("sPlot is " + sPlot);

    // is the plot completed
    int bCompleted = GetLocalInt(oDungeon, "b" + sPlot + "Completed");
    if (bCompleted == TRUE)
    {
        object oPC = GetPCSpeaker();
        string sIdentifier = GetPCIdentifier(oPC);
        int bPlayer = GetLocalInt(oDungeon, "b" + sPlot + "Player_" + sIdentifier);
        if (bPlayer == FALSE)
        {
            return TRUE;
        } else
        {
            return FALSE;
        }
    } else
    {
        return FALSE;
    }
}
