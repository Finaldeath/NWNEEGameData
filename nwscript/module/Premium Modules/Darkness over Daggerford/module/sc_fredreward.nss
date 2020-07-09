int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iFrederickReward") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
