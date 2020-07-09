// special handler for not yet response -- player has quest but has not
// yet discovered anything

int StartingConditional()
{
    int nPlot = GetLocalInt(GetModule(),"barge_activity");
    return (nPlot == 1);
}
