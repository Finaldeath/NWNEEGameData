//December 2005
// B W-Husey
// PC failed the Theft to Order sidequest. Conditional

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nToOrder") == 5))
        return FALSE;

    return TRUE;
}
