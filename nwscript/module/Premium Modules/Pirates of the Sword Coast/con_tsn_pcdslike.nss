int StartingConditional()
{
    int iResult = FALSE;

    if (GetLocalInt(GetModule(), "INT_TASINA_ATTITUDE") < -3)
    {
        iResult = TRUE;
    }
    return iResult;
}
