int StartingConditional()
{
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oPlotDungeon = RetrieveCampaignObject("ID_DATABASE", "Dungeon-2", lLocation);
    if (oPlotDungeon != OBJECT_INVALID)
    {
        string sDungeonName = GetLocalString(oPlotDungeon, "sDungeonName");
        SetCustomToken(5202, sDungeonName);

        DestroyObject(oPlotDungeon);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
