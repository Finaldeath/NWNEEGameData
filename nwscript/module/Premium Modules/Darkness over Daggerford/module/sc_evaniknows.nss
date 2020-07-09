int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iEvaniKnowsThief") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
