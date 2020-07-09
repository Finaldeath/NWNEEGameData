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
        oDungeon = GetLocalObject(oHolder, sName);
        if (oDungeon == OBJECT_INVALID)
        {
            DebugMessage("  nDungeon" + IntToString(nDungeon) + " is not present.");
        } else
        {
            DebugMessage("  Storing nDungeon" + IntToString(nDungeon) + ".");
            StoreCampaignObject("ID_DATABASE", sName, oDungeon);

            DelayCommand(0.01, DestroyObject(oDungeon));
        }
        nDungeon++;
    }

    if (nDungeon < 100)
    {
        DebugMessage("    Examining next dungeon.");

        SetLocalInt(GetModule(), "nQueueMin", nDungeon);

        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", lLocation, FALSE, "MicroCPU129");
        SetLocalObject(oMicroCPU, "oParent", oParent);
        SetLocalObject(oMicroCPU, "oHolder", oHolder);
        DelayCommand(0.01, ExecuteScript("exe_id1_rebuild2", oMicroCPU));

        DelayCommand(0.02, DestroyObject(OBJECT_SELF));
    } else
    {
        DebugMessage("    Returning to conversation.");

        SetLocalInt(GetModule(), "nQueueMin", 1);

        AssignCommand(oParent, ActionResumeConversation());

        DestroyObject(oHolder);

        DelayCommand(0.02, DestroyObject(OBJECT_SELF));
    }
}
