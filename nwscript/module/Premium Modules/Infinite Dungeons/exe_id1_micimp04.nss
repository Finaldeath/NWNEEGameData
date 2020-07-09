#include "inc_id1_utility"

void main()
{
    DebugMessage("");
    DebugMessage("Importing damage types.");

    int nImport = GetLocalInt(OBJECT_SELF, "nImport");
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");
    DebugMessage("Import = " + IntToString(nImport));

    int nRange = nImport + 100;
    int bFail = FALSE;

    int nNum = GetLocalInt(oImport, "nListDamageTypeNum");
    DebugMessage("  Number is " + IntToString(nNum));

    if (nRange > nNum)
    {
        nRange = nNum;
    }

    int nID;
    int nID2;
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    while ((nImport <= nRange) && (bFail == FALSE))
    {
        nID = GetLocalInt(oImport, "nListDamageType" + IntToString(nImport) + "ID");
        nID2 = GetLocalInt(GetModule(), "nDamageType_" + IntToString(nID));
        DebugMessage("  ID " + IntToString(nID) + " is module damage type " + IntToString(nID2));

        if (nID2 > 0)
        {
            nImport++;
        } else
        {
            bFail = TRUE;
        }
    }

    if (bFail == TRUE)
    {
        SetLocalInt(oParent, "bImportFailed", TRUE);
        AssignCommand(oParent, ActionResumeConversation());
    } else
    {
        // if all have been examined
        if (nImport > nNum)
        {
            AssignCommand(oParent, ActionResumeConversation());
        } else // more to be examined
        {
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU76");
            SetLocalObject(oMicroCPU, "oParent", oParent);
            SetLocalObject(oMicroCPU, "oImport", oImport);
            SetLocalInt(oMicroCPU, "nImport", nImport);
            DelayCommand(0.01, ExecuteScript("exe_id1_micimp04", oMicroCPU));
        }
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
