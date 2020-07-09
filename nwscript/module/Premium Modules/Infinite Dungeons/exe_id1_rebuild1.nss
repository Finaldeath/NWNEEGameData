#include "inc_id1_debug"

void main()
{
    int nDungeon = GetLocalInt(GetModule(), "nQueueMin");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");
    object oHolder = GetLocalObject(OBJECT_SELF, "oHolder");
    location lLocation = GetLocation(GetObjectByTag("CPU"));

    object oDungeon = OBJECT_INVALID;
    string sName;
    while ((oDungeon == OBJECT_INVALID) && (nDungeon <= 100))
    {
        sName = "Dungeon" + IntToString(nDungeon);
        oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
        if (oDungeon == OBJECT_INVALID)
        {
            DebugMessage("  nDungeon" + IntToString(nDungeon) + " is invalid.");
        } else
        {
            DebugMessage("  nDungeon" + IntToString(nDungeon) + " exists.");
            SetLocalObject(oHolder, sName, oDungeon);
        }
        nDungeon++;
    }

    if (nDungeon < 100)
    {
        DebugMessage("    Examining next dungeon.");

        SetLocalInt(GetModule(), "nQueueMin", nDungeon);

        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", lLocation, FALSE, "MicroCPU127");
        SetLocalObject(oMicroCPU, "oParent", oParent);
        SetLocalObject(oMicroCPU, "oHolder", oHolder);
        DelayCommand(0.01, ExecuteScript("exe_id1_rebuild1", oMicroCPU));

        DelayCommand(0.02, DestroyObject(OBJECT_SELF));
    } else
    {
        DebugMessage("    Advancing to write process.");

      //  DestroyCampaignDatabase("ID_DATABASE");

        SetLocalInt(GetModule(), "nQueueMin", -7);

        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", lLocation, FALSE, "MicroCPU128");
        SetLocalObject(oMicroCPU, "oParent", oParent);
        SetLocalObject(oMicroCPU, "oHolder", oHolder);
        DelayCommand(0.01, ExecuteScript("exe_id1_rebuild2", oMicroCPU));

        DelayCommand(0.02, DestroyObject(OBJECT_SELF));
    }
}
