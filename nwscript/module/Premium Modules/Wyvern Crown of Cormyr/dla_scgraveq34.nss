//January 2006
// B W-Husey
// PC has a grave.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 4)
        return TRUE;
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 3)
        return TRUE;

        return FALSE;

}
