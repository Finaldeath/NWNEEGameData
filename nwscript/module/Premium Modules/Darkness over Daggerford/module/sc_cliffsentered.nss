int StartingConditional()
{
    if(GetLocalInt(GetModule(),"iCliffsEntered") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
