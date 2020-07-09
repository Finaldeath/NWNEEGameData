#include "inc_id1_utility"

void main()
{
    DebugMessage("");

    int nExport = GetLocalInt(OBJECT_SELF, "nExport");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    int nRange = nExport + 100;
    if (nRange > 999)
    {
        nRange = 999;
    }
    DebugMessage("Export range " + IntToString(nRange));

    string sFileName = "ID_" + IntToStringDigits(nExport, 3);
    location lLocation = GetLocation(GetWaypointByTag("CPU"));
    object oExport = RetrieveCampaignObject(sFileName, "oDungeon", lLocation);
    while ((nExport < nRange) && (oExport != OBJECT_INVALID))
    {
        DestroyObject(oExport);
        nExport++;
        sFileName = "ID_" + IntToStringDigits(nExport, 3);
        DebugMessage("Checking " + sFileName);
        lLocation = GetLocation(GetWaypointByTag("CPU"));
        oExport = RetrieveCampaignObject(sFileName, "oDungeon", lLocation);
    }

    if (oExport == OBJECT_INVALID)
    {
        SetLocalInt(oParent, "nExport", nExport);
        AssignCommand(oParent, ActionResumeConversation());
    } else
    {
        DestroyObject(oExport);

        if (nExport < 999)
        {
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU72");
            SetLocalObject(oMicroCPU, "oParent", oParent);
            SetLocalInt(oMicroCPU, "nExport", nExport);
            DelayCommand(0.01, ExecuteScript("exe_id1_micexpsr", oMicroCPU));
        } else
        {
            AssignCommand(oParent, ActionResumeConversation());
        }
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
