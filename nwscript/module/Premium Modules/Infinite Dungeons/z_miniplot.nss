void main()
{
    if (GetLocalInt(GetModule(), "bMiniPlot") == FALSE)
    {
        SetLocalInt(GetModule(), "bMiniPlot", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMiniPlot", FALSE);
    }
}
