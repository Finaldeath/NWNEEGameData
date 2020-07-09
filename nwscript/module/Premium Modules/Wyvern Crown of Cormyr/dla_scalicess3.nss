//November 2005
// B W-Husey
// To be a Spy condiional used on Alice Broadhand
// nSpy = 3 (found secret entrance)
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSpy") == 3))
        return FALSE;

    return TRUE;
}
