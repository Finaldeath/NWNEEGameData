#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int nNum = GetLocalInt(OBJECT_SELF, "nNum");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");
    int nLevelNum = GetLocalInt(OBJECT_SELF, "nLevelNum");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing information for plot " + IntToString(nNum));

    string sPlot = "Plot" + IntToString(nNum);

    // level num
    int nPlotLevelNum = GetLocalInt(oImport, "n" + sPlot + "LevelNum");
    int nPlotLevel = 1;
    int nPlotAreaNum;
    int nPlotArea;
    int nArea;
    int nLevel;
    string sLevel;
    while (nPlotLevel <= nPlotLevelNum)
    {
        nLevel = GetLocalInt(oImport, "n" + sPlot + "Level" + IntToString(nPlotLevel));

        sLevel = sPlot + "Level" + IntToString(nPlotLevel);

        // area num
        nPlotAreaNum = GetLocalInt(oImport, "n" + sLevel + "AreaNum");
        nPlotArea = 1;
        while (nPlotArea <= nPlotAreaNum)
        {

            // cleared
            SetLocalInt(oImport, "b" + sLevel + "Area" + IntToString(nPlotArea) + "Cleared", FALSE);

            // explored
            SetLocalInt(oImport, "b" + sLevel + "Area" + IntToString(nPlotArea) + "Explored", FALSE);

            nPlotArea++;
        }

        nPlotLevel++;
    }

    // activated
    SetLocalInt(oImport, "b" + sPlot + "Activated", FALSE);

    // completed
    SetLocalInt(oImport, "b" + sPlot + "Completed", FALSE);

    // failed
    SetLocalInt(oImport, "b" + sPlot + "Failed", FALSE);

    // player num
    int nPlayerNum = GetLocalInt(oImport, "n" + sPlot + "PlayerNum");
    string sPlayer;
    int nPlayer = 1;
    while (nPlayer <= nPlayerNum)
    {
        sPlayer = GetLocalString(oImport, "s" + sPlot + "Player" + IntToString(nPlayer));
        SetLocalString(oImport, "s" + sPlot + "Player" + IntToString(nPlayer), "");

        SetLocalInt(oImport, "b" + sPlot + "Player_" + sPlayer, FALSE);

        nPlayer++;
    }

    // creatures killed
    SetLocalInt(oImport, "n" + sPlot + "CreaturesKilled", 0);

    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    int nMicroDead = GetLocalInt(GetModule(), "nImportMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nImportMicroDead", nMicroDead);
    DebugMessage("  There are " + IntToString(nMicroNum) + " living and " + IntToString(nMicroDead) + " dead microprocesses.");
    if (nMicroDead >= nMicroNum)
    {
        AssignCommand(oParent, ActionResumeConversation());
    }
    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
