int StartingConditional()
{
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotTotal");

    if (nPlotTypeNum > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
