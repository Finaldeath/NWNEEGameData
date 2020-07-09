int StartingConditional()
{
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotActivated");

    if (nPlotTypeNum > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
