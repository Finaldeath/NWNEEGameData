int StartingConditional()
{
    if (GetLocalInt(GetModule(), "luce_001_done"))
        return FALSE;

    return TRUE;
}
