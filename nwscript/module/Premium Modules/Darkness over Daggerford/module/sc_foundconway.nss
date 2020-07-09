int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iFoundAssaultNote") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
