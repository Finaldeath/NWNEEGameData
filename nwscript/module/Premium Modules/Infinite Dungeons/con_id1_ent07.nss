int StartingConditional()
{
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oPlotDungeon = RetrieveCampaignObject("ID_DATABASE", "Dungeon-3", lLocation);
    if (oPlotDungeon != OBJECT_INVALID)
    {
        string sDungeonName = GetLocalString(oPlotDungeon, "sDungeonName");
        SetCustomToken(5203, sDungeonName);

        DestroyObject(oPlotDungeon);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
