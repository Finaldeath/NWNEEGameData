int StartingConditional()
{
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");

    if (nCurrentPage > 1)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
