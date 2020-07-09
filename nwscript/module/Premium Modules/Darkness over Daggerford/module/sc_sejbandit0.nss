int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "ac_sej_bandit") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
