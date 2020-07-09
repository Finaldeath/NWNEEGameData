void main()
{
    if (GetLocalInt(GetModule(), "bPlotDungeon") == FALSE)
    {
        SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bPlotDungeon", FALSE);
    }
}
