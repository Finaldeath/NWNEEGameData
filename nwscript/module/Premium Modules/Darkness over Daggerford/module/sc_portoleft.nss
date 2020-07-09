int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iPortoLeft") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
