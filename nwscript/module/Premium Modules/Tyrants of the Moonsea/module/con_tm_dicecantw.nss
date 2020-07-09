//Is courier's score 19 or 20? From this position, he can't roll again
//without going over 21, so has lost
int StartingConditional()
{
    int nRunningTotal = GetLocalInt(OBJECT_SELF, "nRunningTotal");

    if(nRunningTotal == 19 || nRunningTotal == 20)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
