int StartingConditional()
{
    int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotTypeNum");

    if (nPlotTypeNum > (nOffset + 10))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
