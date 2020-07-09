// if hevesar's plots are done, the barracuda door won't open

int StartingConditional()
{
    return(GetLocalInt(GetModule(), "hevesar_plot") >= 6);
}
