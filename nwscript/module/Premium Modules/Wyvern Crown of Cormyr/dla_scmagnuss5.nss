// October 2005
// B W-Husey
//nPoltergeist is = 5, i.e. the PC has exorcised the poltergeist.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nPoltergeist") == 5))
        return FALSE;

    return TRUE;
}
