int StartingConditional()
{
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotFailed");

    if (nPlotTypeNum > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
