int StartingConditional()
{
    // if harat is dead
    if (GetLocalInt(GetModule(), "bHaratDead") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
