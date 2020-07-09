//December 2005
// B W-Husey
// Hawklin knows about Salvatori.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nHawklinPlot2") > 2))
        return FALSE;

    return TRUE;
}
