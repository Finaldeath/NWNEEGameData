int StartingConditional()
{
    if(GetLocalInt(GetModule(), "npm_delfen_PL") == 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
