int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "nCurrentPage") > 1)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
