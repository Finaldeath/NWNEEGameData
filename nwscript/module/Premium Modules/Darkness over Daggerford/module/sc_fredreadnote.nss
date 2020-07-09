int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iFredReadNote") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
