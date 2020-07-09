//January 2006
// B W-Husey
// PC knows his father's grave is defaced and not yet ordered a fix

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 5)
        return TRUE;
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 7)
        return TRUE;

    return FALSE;
}
