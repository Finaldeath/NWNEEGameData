int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetModule(), "nIH_HelmRestored") == 1);
    return iResult;
}
