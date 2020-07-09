int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iEnteredCellar") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
