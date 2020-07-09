int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iMetJericksLad") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
