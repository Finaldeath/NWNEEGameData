int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetPCSpeaker(), "nWH_PaidToll") == 1); // paid toll
    return iResult;
}
