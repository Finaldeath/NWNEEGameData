// has the player heard about brattal yet?

int StartingConditional()
{
    int nPlot = GetLocalInt(GetModule(), "nVeitiBrattalLevel");
    return(nPlot > 0);
}
