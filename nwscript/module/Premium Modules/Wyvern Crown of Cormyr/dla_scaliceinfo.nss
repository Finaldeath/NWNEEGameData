//February 2006
// B W-Husey
// Alice has not been asked for info
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nInfoPoltGath") == 0))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nAInfo") == 0))
        return FALSE;

    return TRUE;
}
