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

        DelayCommand(0.01, ExecuteScript("exe_id1_rebuild3", GetNextCPU()));
    } else
    {
        DebugMessage("    Advancing to write process.");

      //  DestroyCampaignDatabase("ID_DATABASE");

        SetLocalInt(GetModule(), "nQueueMin", -7);

        DelayCommand(0.01, ExecuteScript("exe_id1_rebuild4", GetNextCPU()));
    }
}
