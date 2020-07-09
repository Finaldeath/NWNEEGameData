int StartingConditional()
{
    if((GetLocalInt(GetPCSpeaker(), "ac_maero_tell") == 1) &&
        GetLocalInt(GetPCSpeaker(), "ac_kill_miller") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
