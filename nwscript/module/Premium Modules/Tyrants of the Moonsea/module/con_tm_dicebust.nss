//Has player scored more than 21 in game of 21 in Gate of Good Fortune casino
int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "nRunningTotal") > 21)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
