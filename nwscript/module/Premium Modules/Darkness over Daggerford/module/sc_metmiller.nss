int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "ac_kill_miller") == 1 ||
       GetLocalInt(GetPCSpeaker(), "ac_loru_diary") == 1 ||
       GetLocalInt(GetPCSpeaker(), "ac_kill_loru") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
