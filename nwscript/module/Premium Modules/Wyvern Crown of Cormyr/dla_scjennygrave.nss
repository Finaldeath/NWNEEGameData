//January 2006
// B W-Husey
// Conditional that triggers Jenny to talk about the defaced grave.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nJennyDone") == 0))  //not talked
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nNoGrave") > 0))  //grave is defaced
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 1)) //Not needed, but insurance
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nGrave") < 7))  //not confronted knight already
        return FALSE;

    return TRUE;
}
