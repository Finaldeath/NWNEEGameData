int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "nCurrentPage") < 91)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
