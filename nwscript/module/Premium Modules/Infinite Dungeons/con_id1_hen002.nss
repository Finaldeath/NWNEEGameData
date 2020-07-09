int StartingConditional()
{
    int nMaxHitPoints = GetMaxHitPoints();
    int nCurrentHitPoints = GetCurrentHitPoints();
    int nCutoff = FloatToInt(nMaxHitPoints * 0.7);
    if (nCutoff < 1)
    {
        nCutoff = 1;
    }
    if (nCurrentHitPoints <= nCutoff)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
