int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(OBJECT_SELF, "nActivated") == 1);
    return iResult;
}
