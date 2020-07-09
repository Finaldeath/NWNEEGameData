int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "nCurrentPage") > 10)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
