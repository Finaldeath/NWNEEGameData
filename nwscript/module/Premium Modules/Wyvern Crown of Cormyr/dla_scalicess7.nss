//November 2005
// B W-Husey
// To be a Spy condiional used on Alice Broadhand/Hawklin
// nSpy = 7 (Hawklin told PC about secret entrance, reported to Alice)
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSpy") == 7))
        return FALSE;

    return TRUE;
}
