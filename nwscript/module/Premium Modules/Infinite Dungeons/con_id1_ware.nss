int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nCurrentLevel") > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
