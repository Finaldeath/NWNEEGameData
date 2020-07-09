// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

int StartingConditional()
{
    int nDungeonState = GetLocalInt(OBJECT_SELF, "nDungeonState");
    if ((nDungeonState == 1) || (nDungeonState == 2) || (nDungeonState == 4))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
