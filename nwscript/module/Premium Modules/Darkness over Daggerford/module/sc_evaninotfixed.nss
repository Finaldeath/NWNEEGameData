int StartingConditional()
{
    if(GetLocalInt(GetModule(), "evani_fixed") != 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
