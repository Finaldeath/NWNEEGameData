#include "inc_id1_utility"

void main()
{
    DebugMessage("");
    DebugMessage("Importing plot containers.");

    int nImport = GetLocalInt(OBJECT_SELF, "nImport");
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");
    DebugMessage("Import = " + IntToString(nImport));

    int nRange = nImport + 100;
    int bFail = FALSE;

    int nNum = GetLocalInt(oImport, "nListPlotContainerNum");
    DebugMessage("  Number is " + IntToString(nNum));

    if (nRange > nNum)
    {
        nRange = nNum;
    }

    string sResRef;
    object oObject;
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    while ((nImport <= nRange) && (bFail == FALSE))
    {
        sResRef = GetLocalString(oImport, "sListPlotContainer" + IntToString(nImport) + "ResRef");
        oObject = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation);
        DebugMessage("  Created object " + IntToString(nImport) + " with tag " + sResRef + " and name " + GetName(oObject));

        if (oObject != OBJECT_INVALID)
        {
            nImport++;
        } else
        {
            bFail = TRUE;
        }

        DestroyObject(oObject);
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
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU79");
            SetLocalObject(oMicroCPU, "oParent", oParent);
            SetLocalObject(oMicroCPU, "oImport", oImport);
            SetLocalInt(oMicroCPU, "nImport", nImport);
            DelayCommand(0.01, ExecuteScript("exe_id1_micimp07", oMicroCPU));
        }
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
