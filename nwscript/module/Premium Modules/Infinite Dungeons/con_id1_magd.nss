int StartingConditional()
{
    // if maggris is dead
    if (GetLocalInt(GetModule(), "bMaggrisDead") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
