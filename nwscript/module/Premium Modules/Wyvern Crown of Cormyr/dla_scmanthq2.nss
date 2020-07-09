// October 2005
// B W-Husey
// Manthia's plot variable is at state 2 (Hawklin has told the PC to find Edgar and the barrows)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nManthiaPlot1") == 2))
        return FALSE;

    return TRUE;
}
