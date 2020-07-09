// December 2005
// B W-Husey
// PC has taken the Ride Like a Centaur quest but failed to get the oath out of Huntcrown.
// Used on Manthia2 dialogue

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nManthia1Side") == 2))
        return FALSE;

    return TRUE;
}
