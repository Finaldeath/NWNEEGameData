//November 2005
// B W-Husey
// To be a Spy condiional used on Alice Broadhand
// nSpy = 4 (Hawklin told PC about secret entrance)
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSpy") == 4))
        return FALSE;

    return TRUE;
}
