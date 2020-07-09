//January 2006
// B W-Husey
// PC has completed the Family Grave quest, but the knight is still alive.
int StartingConditional()
{

    // Inspect local variables

    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 9)
        return TRUE;
    return FALSE;
}
