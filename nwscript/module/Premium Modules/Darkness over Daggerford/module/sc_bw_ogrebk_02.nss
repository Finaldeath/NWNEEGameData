int StartingConditional()
{
    int iResult;

    iResult =(GetLocalInt(GetPCSpeaker(), "nWH_PaidToll") == 100); // safe to cross always
    return iResult;
}
