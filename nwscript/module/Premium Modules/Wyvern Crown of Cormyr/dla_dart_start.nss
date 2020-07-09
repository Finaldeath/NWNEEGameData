void main()
{
    int nHigh = GetLocalInt(OBJECT_SELF,"nMaxDartBet");
    int nGold = GetLocalInt(OBJECT_SELF,"nDartGold");
    if(nHigh<nGold)
    {
        nHigh = nGold;
    }
    string sHigh = IntToString(nHigh);
    string sAmount = GetLocalString(OBJECT_SELF,"nDartWager");
    //Set the Bet Amount token
    SetCustomToken(1030,sAmount);
    //Set the High Amount token
    SetCustomToken(1031,sHigh);
}
