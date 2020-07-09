int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "ac_nosfiraat_qst") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
