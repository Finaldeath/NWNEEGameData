//February 2006
// B W-Husey
// PC has heard from the keeper about the mirrors.
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "G3Keeper") != 1)
        return FALSE;

    return TRUE;
}
