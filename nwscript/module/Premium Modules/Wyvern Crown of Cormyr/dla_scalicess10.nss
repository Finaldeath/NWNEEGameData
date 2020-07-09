//November 2005
// B W-Husey
// To be a Spy condiional used on Alice Broadhand/Hawklin
// nSpy = 10 (Had agent encounter on the road)
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nSpy") == 10)
        return TRUE;

    return FALSE;
}
