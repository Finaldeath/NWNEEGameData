//November 2005
// B W-Husey
// To be a Spy condiional used on Alice Broadhand
// nSpy = 2 (failed to find secret entrance)
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSpy") == 2))
        return FALSE;

    return TRUE;
}
