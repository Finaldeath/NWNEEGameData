//December 2005
// B W-Husey
// PC gave the horn to Huntcrown.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nToOrder") == 3))
        return FALSE;

    return TRUE;
}
