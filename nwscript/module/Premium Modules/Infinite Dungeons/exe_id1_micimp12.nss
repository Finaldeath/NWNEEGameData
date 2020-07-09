#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int nNum = GetLocalInt(OBJECT_SELF, "nNum");
    int nAreaNum = GetLocalInt(OBJECT_SELF, "nAreaNum");
    int nLevelNum = GetLocalInt(OBJECT_SELF, "nLevelNum");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing player exploration information for player " + IntToString(nNum));

    // score
    string sPlayer = GetLocalString(oImport, "sPlayer" + IntToString(nNum) + "Identifier");
    SetLocalString(oImport, "sPlayer" + IntToString(nNum) + "Identifier", "");

    SetLocalInt(oImport, "nPlayer_" + sPlayer, 0);

    SetLocalInt(oImport, "nStatisticsPoints_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsDeaths_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsCreaturesKilled_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsLevelsGained_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsPuzzlesSolved_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsAreasDiscovered_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsMaxDepth_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsSecretsDiscovered_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsLockPicked_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsTrapsDisarmed_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsPlotsCompleted_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsBossesDefeated_" + sPlayer, 0);
    SetLocalInt(oImport, "nStatisticsMiniBossesDefeated_" + sPlayer, 0);

    int nArea = 1;
    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    object oMicroCPU;
    while (nArea <= nAreaNum)
    {
        // exploration
        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU83");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nLevelNum", nNum);
        SetLocalInt(oMicroCPU, "nArea", nArea);
        SetLocalInt(oMicroCPU, "nNum", nNum);
        SetLocalObject(oMicroCPU, "oParent", oParent);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp16", oMicroCPU));

        nArea++;
    }
    SetLocalInt(GetModule(), "nImportMicroNum", nMicroNum);

    nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
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
