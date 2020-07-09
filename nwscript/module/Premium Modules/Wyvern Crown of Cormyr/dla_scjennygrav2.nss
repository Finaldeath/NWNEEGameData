//January 2006
// B W-Husey
// Conditional that triggers Jenny to talk about the defaced grave.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nNoGrave") == 1))
        return FALSE;

    return TRUE;
}
