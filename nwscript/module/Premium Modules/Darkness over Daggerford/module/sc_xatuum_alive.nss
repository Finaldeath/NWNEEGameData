int StartingConditional()
{
    if(GetLocalInt(GetModule(), "nXatuumKilled") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
