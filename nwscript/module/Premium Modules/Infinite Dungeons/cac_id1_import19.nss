#include "inc_id1_debug"

void main()
{
    ActionPauseConversation();

    SetLocalInt(GetModule(), "nImportMicroNum", 0);
    SetLocalInt(GetModule(), "nImportMicroDead", 0);

    // clean up the variable list
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    object oMicroCPU;

    int nMicroNum = 0;

    // depth
    int nDungeonDepth = GetLocalInt(oImport, "nDungeonDepth");
    int nCount = 1;
    while (nCount <= nDungeonDepth)
    {
        DebugMessage("  Creating process for level " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU25");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp25", oMicroCPU));

        nCount++;
    }

    // area num
    int nAreaNum = GetLocalInt(oImport, "nAreaNum");
    nCount = 1;
    while (nCount <= nAreaNum)
    {
        DebugMessage("  Creating process for area " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU26");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        SetLocalInt(oMicroCPU, "nLevelNum", nDungeonDepth);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp26", oMicroCPU));

        nCount++;
    }

    // plot num
    int nPlotNum = GetLocalInt(oImport, "nPlotNum");
    nCount = 1;
    while (nCount <= nPlotNum)
    {
        DebugMessage("  Creating process for plot " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU27");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        SetLocalInt(oMicroCPU, "nLevelNum", nDungeonDepth);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp28", oMicroCPU));

        nCount++;
    }

    // player exploration data
    int nPlayerNum = GetLocalInt(oImport, "nPlayerNum");
    SetLocalInt(oImport, "nPlayerNum", 0);
    nCount = 1;
    while (nCount <= nPlayerNum)
    {
        DebugMessage("  Creating process for player " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU28");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nLevelNum", nDungeonDepth);
        SetLocalInt(oMicroCPU, "nAreaNum", nAreaNum);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp12", oMicroCPU));

        nCount++;
    }

    DebugMessage("  Creating process for dialog.");

    nMicroNum++;
    oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU29");
    SetLocalObject(oMicroCPU, "oImport", oImport);
    SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
    DelayCommand(0.01, ExecuteScript("exe_id1_micimp29", oMicroCPU));

    SetLocalInt(GetModule(), "nImportMicroNum", nMicroNum);
    DebugMessage("There are " + IntToString(nMicroNum) + " import micro processes.");
}
