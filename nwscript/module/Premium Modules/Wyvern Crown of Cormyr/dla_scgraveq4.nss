//January 2006
// B W-Husey
// PC knows his father's grave but not by whom.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 4)
        return TRUE;

        return FALSE;

}
