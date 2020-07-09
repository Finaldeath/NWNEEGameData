int StartingConditional()
{
    if (GetLocalInt(GetModule(), "luce_001_done"))
        return TRUE;

    return FALSE;
}
