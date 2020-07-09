int StartingConditional()
{
    int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int nMaxPage = nDungeonNum / 10;
    if (nDungeonNum > (nMaxPage * 10))
    {
        nMaxPage++;
    }
    if (GetLocalInt(OBJECT_SELF, "nCurrentPage") < nMaxPage)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
