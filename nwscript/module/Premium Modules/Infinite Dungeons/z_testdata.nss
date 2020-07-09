void main()
{
    PrintString("");
    PrintString("Testing campaign database function.");

    int nCount = -7;
    object oDungeon;
    string sName;
    int bReturn;
    location lLocation = GetLocation(GetObjectByTag("CPU"));

    while (nCount <= 100)
    {
        oDungeon = CreateObject(OBJECT_TYPE_ITEM, "dungeonobject", lLocation);
        sName = "Dungeon" + IntToString(nCount);
        PrintString("Adding dungeon " + sName);
        SetLocalString(oDungeon, "Name", sName);
        bReturn = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
        PrintString("  Returned value is " + IntToString(bReturn));

        nCount++;
    }

    nCount = -7;
    while (nCount <= 100)
    {
        sName = "Dungeon" + IntToString(nCount);
        PrintString("Reading dungeon " + sName);
        oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
        if (oDungeon == OBJECT_INVALID)
        {
            PrintString("  Object was invalid.");
        } else
        {
            sName = GetLocalString(oDungeon, "Name");
            PrintString("  Retrieved name is " + sName);
        }

        nCount++;
    }

    PrintString("");
}
