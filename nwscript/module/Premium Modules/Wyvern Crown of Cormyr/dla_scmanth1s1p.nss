// December 2005
// B W-Husey
// PC has taken the Ride Like a Centaur quest and not completed it

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nManthia1Side") > 0))
        return FALSE;

    if(GetLocalInt(GetPCSpeaker(), "nManthia1Side") > 4)
        return FALSE;

    return TRUE;
}
