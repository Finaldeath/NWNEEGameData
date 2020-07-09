int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iRabDone") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
