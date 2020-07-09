// October 2005
// B W-Husey
// Manthia's plot variable is > 1 (Hawklin has told the PC to find Edgar and the barrows)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nManthiaPlot1") > 1))
        return FALSE;

    return TRUE;
}
