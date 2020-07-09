// December 2005
// B W-Husey
// PC has taken the Ride Like a Centaur quest but not progressed. Used on a variety of dialogues, not
// just Manthia's

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nManthia1Side") == 1))
        return FALSE;

    return TRUE;
}
