#include "inc_id1_utility"

void main()
{
    // feedback
    object oSpeaker = GetLocalObject(GetModule(), "oSpeaker");
    AssignCommand(oSpeaker, SpeakString("Rebuilding database."));

    SetLocalInt(GetModule(), "nQueueMin", -7);

    location lLocation = GetLocation(GetObjectByTag("CPU"));

    object oHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", lLocation, FALSE, "MicroCPU125");
    SetLocalObject(GetModule(), "oTempHolder", oHolder);

    DelayCommand(0.01, ExecuteScript("exe_id1_rebuild3", GetNextCPU()));

/*
    // rebuild the database
    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU104");

    int nDungeon = -7;
    object oDungeon;
    string sName;
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    while (nDungeon <= 100)
    {
        if (nDungeon != 0)
        {
            sName = "Dungeon" + IntToString(nDungeon);
            oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
            if (oDungeon != OBJECT_INVALID)
            {
                SetLocalObject(oMicroCPU, sName, oDungeon);
            }
        }

        nDungeon++;
    }

    DestroyCampaignDatabase("ID_DATABASE");

    nDungeon = -7;
    while (nDungeon <= 100)
    {
        if (nDungeon != 0)
        {
            sName = "Dungeon" + IntToString(nDungeon);
            oDungeon = GetLocalObject(oMicroCPU, sName);
            if (oDungeon != OBJECT_INVALID)
            {
                StoreCampaignObject("ID_DATABASE", sName, oDungeon);

                DestroyObject(oDungeon);
            }
        }

        nDungeon++;
    }

    DestroyObject(oMicroCPU);

    // generate the level
    SetLocalInt(GetModule(), "nLevelProcess", 0);
    DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));*/
}
