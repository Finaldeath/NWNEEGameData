void main()
{
    int nHigh = GetLocalInt(OBJECT_SELF,"nDartMaxBet");
    int nGold = GetLocalInt(OBJECT_SELF,"nDartGold");
    if(nGold<nHigh)
    {
        nHigh = nGold;
    }
    string sHigh = IntToString(nHigh);
    string sAmount = "5";
    SetLocalInt(OBJECT_SELF,"nDartWager",5);
    //Set the Bet Amount token
    SetCustomToken(1030,sAmount);
    //Set the High Amount token
    SetCustomToken(1031,sHigh);
}
