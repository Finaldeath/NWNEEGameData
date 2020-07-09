//January 2006
// B W-Husey
// PC has already got a result out of the bad knight (nGrave = 7 or 9)
int StartingConditional()
{

    // Inspect local variables

    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 7)
        return TRUE;
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 9)
        return TRUE;

    return FALSE;
}
