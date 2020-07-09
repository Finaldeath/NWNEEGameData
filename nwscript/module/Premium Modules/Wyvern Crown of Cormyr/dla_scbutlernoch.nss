//December 2005
// B W-Husey
//  In this state the butler doesn't give directions to Huntcrown as PC just asked.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nITalk") == 1))
        return FALSE;

    return TRUE;
}
