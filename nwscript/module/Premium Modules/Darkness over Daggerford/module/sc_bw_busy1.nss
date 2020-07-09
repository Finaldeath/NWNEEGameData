int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(OBJECT_SELF, "nBusy") == 1);
    return iResult;
}
