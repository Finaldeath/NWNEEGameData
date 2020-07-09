#include "inc_id1_utility"

void main()
{
    ActionPauseConversation();

    // default
    SetLocalInt(OBJECT_SELF, "nExport", 999);

    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU1");
    SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
    SetLocalInt(oMicroCPU, "nExport", 1);
    DelayCommand(0.01, ExecuteScript("exe_id1_micexpsr", oMicroCPU));

/*
    int nLineNumber = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeon = nLineNumber + ((nCurrentPage - 1) * 10);
    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon));
    object oDungeon = GetLocalObject(GetModule(), "oDungeonNumber" + IntToString(nDungeonNum));

    // find first available campaign database
    int nExport = 1;
    string sFileName = "ID_" + IntToStringDigits(nExport, 3);
    location lLocation = GetLocation(GetWaypointByTag("CPU"));
    object oExport = RetrieveCampaignObject(sFileName, "oDungeon", lLocation);
    while ((nExport <= 999) && (oExport != OBJECT_INVALID))
    {
        nExport++;
        sFileName = "ID_" + IntToStringDigits(nExport, 3);
        lLocation = GetLocation(GetWaypointByTag("CPU"));
        oExport = RetrieveCampaignObject(sFileName, "oDungeon", lLocation);
    }

    sFileName = "ID_" + IntToStringDigits(nExport, 3);
    SetLocalString(OBJECT_SELF, "sFileName", sFileName);
    lLocation = GetLocation(GetWaypointByTag("CPU"));
    StoreCampaignObject(sFileName, "oDungeon", oDungeon);

    ActionResumeConversation();*/
}
