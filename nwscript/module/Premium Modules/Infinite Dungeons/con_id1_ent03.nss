// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

int StartingConditional()
{
    int nDungeonState = GetLocalInt(OBJECT_SELF, "nDungeonState");
    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    if ((nDungeonState == 4) && (nDungeonListNum < 100) && (bGenerating == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
