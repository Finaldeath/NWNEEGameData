int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetModule(), "nIH_PrisonersFreed") == 1);
    return iResult;
}
