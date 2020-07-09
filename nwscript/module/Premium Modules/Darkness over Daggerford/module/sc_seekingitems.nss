int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "iRecoveredItems") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
