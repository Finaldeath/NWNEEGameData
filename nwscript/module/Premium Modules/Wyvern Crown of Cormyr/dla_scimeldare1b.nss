//December 2005
// B W-Husey
// Variation on the standard conditional for sections 5+ of the module
// (just to keep conversations tidy)
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nRevenge") == 1))
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") < 5)
        return FALSE;
    return TRUE;
}
