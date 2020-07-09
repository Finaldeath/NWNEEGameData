int StartingConditional()
{
    if(GetLocalInt(GetModule(), "nGrimswoldFled") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
