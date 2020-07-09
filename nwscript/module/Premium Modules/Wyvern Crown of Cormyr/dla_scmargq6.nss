//January 2006
// B W-husey
// PC failed abduction quest or refused it

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAbduct") == 6))
        return FALSE;

    return TRUE;
}
