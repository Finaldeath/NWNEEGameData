int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "ac_plague_quest") > 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
