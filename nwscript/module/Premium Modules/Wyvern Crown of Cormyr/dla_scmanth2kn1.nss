//December 2005
// B W-Husey
// PC knows that Huntcrown is interested in horns and/or hunting. Broadhand was the source

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nHOrder") == 1)
    return TRUE;
    return FALSE;
}
