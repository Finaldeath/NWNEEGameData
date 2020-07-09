void main()
{
    int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int nMaxPage = nDungeonNum / 10;
    if (nDungeonNum > (nMaxPage * 10))
    {
        nMaxPage++;
    }
    SetLocalInt(OBJECT_SELF, "nCurrentPage", nMaxPage);
}
