int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iKyleenaDeparted") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
