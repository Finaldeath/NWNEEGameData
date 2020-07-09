//November 2005
// B W-Husey
// To be a Spy condiional used on Alice Broadhand/Hawklin
// nSpy = 9 (Agent escaped the trap)
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nSpy") == 9)
        return TRUE;

    return FALSE;
}
