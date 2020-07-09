//January 2006
// B W-Husey
// PC has a grave quest not completed.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 0)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nGrave") < 9)
        return TRUE;

        return FALSE;

}
