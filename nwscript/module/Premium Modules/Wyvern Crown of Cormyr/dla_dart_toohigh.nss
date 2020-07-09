int StartingConditional()
{
    int iResult;
    int nHigh = GetLocalInt(OBJECT_SELF,"nDartMaxBet");
    int nGold = GetLocalInt(OBJECT_SELF,"nDartGold");
    int nBet = GetLocalInt(OBJECT_SELF,"nDartWager");
    if(nBet > nGold || nBet > nHigh)
    {
        return TRUE;
    }
    return FALSE;
}
