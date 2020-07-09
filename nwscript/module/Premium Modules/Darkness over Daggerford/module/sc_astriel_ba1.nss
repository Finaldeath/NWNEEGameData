// has the player been given the barge activity quest yet?

int StartingConditional()
{
    int nPlot = GetLocalInt(GetModule(),"barge_activity");
    return (nPlot == 1 || nPlot == 2 || nPlot == 3);
}
