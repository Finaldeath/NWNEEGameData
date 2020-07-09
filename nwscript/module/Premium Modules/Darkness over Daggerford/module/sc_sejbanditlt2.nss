int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "ac_sej_bandit") < 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
