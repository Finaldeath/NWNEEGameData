int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iKilledTalkingBird") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
