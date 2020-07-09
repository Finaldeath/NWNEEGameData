int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iShownMaerovynaNote") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
