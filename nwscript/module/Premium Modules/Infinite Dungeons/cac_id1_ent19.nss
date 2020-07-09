void main()
{
/*    // assemble list of custom dungeons
    int nDungeonNum = 0;
    int nDungeon = 1;
    object oDungeon;
    while (nDungeon <= 100)
    {
        oDungeon = GetLocalObject(GetModule(), "oDungeonNumber" + IntToString(nDungeon));
        if (oDungeon != OBJECT_INVALID)
        {
            nDungeonNum++;
            SetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeonNum), nDungeon);
        }

        // check next dungeon
        nDungeon++;
    }
    SetLocalInt(OBJECT_SELF, "nDungeonListNum", nDungeonNum);*/

    SetLocalInt(OBJECT_SELF, "nCurrentPage", 1);
}
