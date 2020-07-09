int StartingConditional()
{
    // if masterius is dead
    if (GetLocalInt(GetModule(), "bMasteriusDead") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
