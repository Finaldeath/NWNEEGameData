//Has the player lost the game of 21 in the Gate of Good Fortune casino?
int StartingConditional()
{
    int nRunningTotal = GetLocalInt(OBJECT_SELF, "nRunningTotal");

    if(nRunningTotal > GetLocalInt(GetPCSpeaker(), "nRunningTotal") &&
       nRunningTotal <= 21)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
