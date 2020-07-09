// December 2005
// B W-Husey
// Generic conditional used on dialogue when the PC knows from Alice Broadhand that
// Lord Huntcrown originally posessed the unicorn horn. (nHOrder = 1)
// Ride like a Centaur quest is TAKEN

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nHOrder") == 1))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nManthia1Side") == 1))
        return FALSE;

    return TRUE;
}
