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
    DebugMessage("  Area number is " + IntToString(nNum));

    // identifier
    int nIdentifier = GetLocalInt(oImport, "nArea" + IntToString(nNum) + "Identifier");
//    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "Identifier", 0);
//    SetLocalInt(oImport, "nIdentifier" + IntToString(nIdentifier) + "Area", 0);

    // for each level
    int nLevel = 1;
    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    object oMicroCPU;
    while (nLevel <= nLevelNum)
    {
        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU85");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nLevel", nLevel);
        SetLocalInt(oMicroCPU, "nNum", nNum);
        SetLocalObject(oMicroCPU, "oParent", oParent);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp23", oMicroCPU));

        nLevel++;
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
