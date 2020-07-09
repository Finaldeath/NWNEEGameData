//December 2005
// B W-Husey
// PC knows that Huntcrown is interested in horns and/or hunting.
// PC has taken the horn quest, but not completed it.
// Modified BGPHughes 19th September 2006

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nHOrder") > 0))
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nToOrder") == 0)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nToOrder") > 2)
        return FALSE;
    return TRUE;
}
