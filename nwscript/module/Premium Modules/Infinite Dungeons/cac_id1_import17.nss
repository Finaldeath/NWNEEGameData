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
    SetLocalInt(oImport, "nMaxLevel", 0);
    int nCount = 1;
    while (nCount <= nDungeonDepth)
    {
        DebugMessage("  Creating process for level " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU15");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp09", oMicroCPU));

        nCount++;
    }

    // area num
    int nAreaNum = GetLocalInt(oImport, "nAreaNum");
    SetLocalInt(oImport, "nAreaNum", 0);
    nCount = 1;
    while (nCount <= nAreaNum)
    {
        DebugMessage("  Creating process for area " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU16");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        SetLocalInt(oMicroCPU, "nLevelNum", nDungeonDepth);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp10", oMicroCPU));

        nCount++;
    }

    // plot num
    int nPlotNum = GetLocalInt(oImport, "nPlotNum");
    SetLocalInt(oImport, "nPlotNum", 0);
    nCount = 1;
    while (nCount <= nPlotNum)
    {
        DebugMessage("  Creating process for plot " + IntToString(nCount));

        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU17");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nNum", nCount);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        SetLocalInt(oMicroCPU, "nLevelNum", nDungeonDepth);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp11", oMicroCPU));

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
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU18");
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
    oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU19");
    SetLocalObject(oMicroCPU, "oImport", oImport);
    SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
    DelayCommand(0.01, ExecuteScript("exe_id1_micimp13", oMicroCPU));

    SetLocalInt(GetModule(), "nImportMicroNum", nMicroNum);
    DebugMessage("There are " + IntToString(nMicroNum) + " import micro processes.");
}
