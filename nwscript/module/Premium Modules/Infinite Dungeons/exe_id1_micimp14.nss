#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    int nNum = GetLocalInt(OBJECT_SELF, "nNum");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing map markers for level " + IntToString(nLevel) + ", column " + IntToString(nNum));

    // map markers
    int nMaxY = GetLocalInt(oImport, "nMaxY");
    int nY = 1;
    string sString = "Level" + IntToString(nLevel) + "Area" + IntToString(nNum) + "_";
    while (nY <= nMaxY)
    {
        SetLocalInt(oImport, "n" + sString + IntToString(nY), 0);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "StairsUp", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "StairsDown", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "Boss", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "Plot", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "Forge", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "Puzzle", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "Camp", FALSE);
        SetLocalInt(oImport, "b" + sString + IntToString(nY) + "SecretDoor", FALSE);

        nY++;
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
