// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

int StartingConditional()
{
    int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    if ((nDungeonListNum > 0) && (nDungeonNumber == 0))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
