int StartingConditional()
{
    int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
    if (nDungeonNumber == 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
