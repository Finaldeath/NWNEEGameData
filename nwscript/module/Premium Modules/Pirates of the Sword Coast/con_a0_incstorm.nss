int StartingConditional()
{
    object oMod = GetModule();
    int iCount = GetLocalInt(oMod, "STORM_COUNTER");
    int iResult = FALSE;

    if (iCount >= 3)
    {
        //SendMessageToPC(GetFirstPC(), "iCount = " + IntToString(iCount));
        iResult = TRUE;
    }

    return iResult;
}
