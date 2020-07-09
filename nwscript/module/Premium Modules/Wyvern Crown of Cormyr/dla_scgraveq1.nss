//January 2006
// B W-Husey
// PC has got father's will, but that's all.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nGrave") == 1))
        return FALSE;

    return TRUE;
}
