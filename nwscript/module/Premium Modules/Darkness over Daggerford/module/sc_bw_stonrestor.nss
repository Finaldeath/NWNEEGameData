int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetModule(), "nIH_RestoredStone") == 1);
    return iResult;
}
