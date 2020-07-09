//Does the courier need to roll again in the game of 21 in the Gate of Good Fortune casino?
int StartingConditional()
{
    int nRunningTotal = GetLocalInt(OBJECT_SELF, "nRunningTotal");
    int nPlayerRunningTotal = GetLocalInt(GetPCSpeaker(), "nRunningTotal");

    if((nRunningTotal < nPlayerRunningTotal && nRunningTotal < 19) ||
       (nRunningTotal == nPlayerRunningTotal && nRunningTotal < 12))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
