// October 2005
// B W-Husey
// Manthia's plot variable is less than 5. Edgar has not joined.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nManthiaPlot1") < 5))
        return FALSE;

    return TRUE;
}
