int StartingConditional()
{
    int nMin = GetLocalInt(OBJECT_SELF, "nMin");
    int nMax = GetLocalInt(OBJECT_SELF, "nMax");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");

    if (((nCurrentPage * 10) + nMin) <= nMax)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
