int StartingConditional()
{
    // if gzhorb is dead
    if (GetLocalInt(GetModule(), "bGzhorbDead") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
