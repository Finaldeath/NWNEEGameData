int StartingConditional()
{
    // if baccha is dead
    if (GetLocalInt(GetModule(), "bBacchaDead") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
