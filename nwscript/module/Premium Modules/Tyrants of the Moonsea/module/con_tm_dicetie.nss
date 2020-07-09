//Are the scores level and the croupier doesn't feel chances are he will win?
int StartingConditional()
{
    int nRunningTotal = GetLocalInt(OBJECT_SELF, "nRunningTotal");

    if(nRunningTotal == GetLocalInt(GetPCSpeaker(), "nRunningTotal") &&
       nRunningTotal >= 12)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
