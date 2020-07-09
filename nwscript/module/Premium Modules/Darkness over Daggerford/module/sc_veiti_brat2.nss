// is this the first time the player has asked Vetii about Brattal?

int StartingConditional()
{
    int nPlot = GetLocalInt(GetModule(), "nVeitiBrattalLevel");
    return(nPlot == 1);
}
