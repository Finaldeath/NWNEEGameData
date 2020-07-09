void main()
{
    ActionPauseConversation();

    // rebuild the database
    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU6");

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
        DestroyObject(oDungeon);

        nDungeon++;
    }

   // DestroyCampaignDatabase("ID_DATABASE");

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
        DestroyObject(oDungeon);

        nDungeon++;
    }

    DestroyObject(oMicroCPU);

    ActionResumeConversation();
}
