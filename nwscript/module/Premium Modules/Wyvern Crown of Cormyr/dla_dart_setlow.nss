void main()
{
    int nHigh = GetLocalInt(OBJECT_SELF,"nDartMaxBet");
    int nGold = GetLocalInt(OBJECT_SELF,"nDartGold");
    int nBet = GetLocalInt(OBJECT_SELF,"nDartWager");

    if(nBet>nHigh)
    {
        nBet = nHigh;
    }
    if(nGold<nBet)
    {
        nBet = nGold;
    }
    string sAmount = IntToString(nBet);
    //Reset the Bet Amount and token
    SetLocalString(OBJECT_SELF,"sDartWager",sAmount);
    SetLocalInt(OBJECT_SELF,"nDartWager",nBet);
    SetCustomToken(1030,sAmount);
}
