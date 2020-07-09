int StartingConditional()
{
    // if hagatha is dead
    if (GetLocalInt(GetModule(), "bHagathaDead") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
