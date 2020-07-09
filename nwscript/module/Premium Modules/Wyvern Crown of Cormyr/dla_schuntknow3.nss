//December 2005
// B W-Husey
// PC knows that Huntcrown is interested in horns and/or hunting. Used on Manthia2 dialogue.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nHOrder") > 0))
        return FALSE;
    return TRUE;
}
