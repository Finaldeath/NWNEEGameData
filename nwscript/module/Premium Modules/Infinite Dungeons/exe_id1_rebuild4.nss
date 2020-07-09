#include "inc_id1_utility"

void main()
{
    int nDungeon = GetLocalInt(GetModule(), "nQueueMin");
    object oSpeaker = GetLocalObject(GetModule(), "oSpeaker");
    AssignCommand(oSpeaker, SpeakString("Rebuilding database."));

    object oHolder = GetLocalObject(GetModule(), "oTempHolder");

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

        DelayCommand(0.01, ExecuteScript("exe_id1_rebuild4", GetNextCPU()));
    } else
    {
        DebugMessage("    Returning to conversation.");

        SetLocalInt(GetModule(), "nQueueMin", 1);

        DestroyObject(oHolder);

        SetLocalInt(GetModule(), "nLevelProcess", 0);
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    }
}
