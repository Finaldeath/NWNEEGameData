int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "moris_reward") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
