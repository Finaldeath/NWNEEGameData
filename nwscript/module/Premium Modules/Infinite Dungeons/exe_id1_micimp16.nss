#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int nLevelNum = GetLocalInt(OBJECT_SELF, "nLevelNum");
    int nArea = GetLocalInt(OBJECT_SELF, "nArea");
    int nNum = GetLocalInt(OBJECT_SELF, "nNum");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing details for player " + IntToString(nNum) + " in area " + IntToString(nArea));

    int nLevel = 1;
    while (nLevel <= nLevelNum)
    {
        SetLocalInt(oImport, "bPlayer" + IntToString(nNum) + "Area" + IntToString(nArea) + "Level" + IntToString(nLevel) + "Explored", FALSE);

        nLevel++;
    }

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
