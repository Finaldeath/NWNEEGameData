int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iKnowsKilledHarpers") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
