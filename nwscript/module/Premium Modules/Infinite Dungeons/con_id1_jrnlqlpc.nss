int StartingConditional()
{
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotCompleted");

    if (nPlotTypeNum > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
