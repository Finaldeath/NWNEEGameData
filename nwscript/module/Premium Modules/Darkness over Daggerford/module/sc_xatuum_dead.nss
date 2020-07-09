int StartingConditional()
{
    if(GetLocalInt(GetModule(), "nXatuumKilled") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
