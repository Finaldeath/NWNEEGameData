int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "ac_kill_loru") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
