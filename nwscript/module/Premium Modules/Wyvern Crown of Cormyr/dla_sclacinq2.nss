// March 2006
// B W-Husey
// Conditional to test state of Ride for a Lady quest
/*  1= In progress
    2= (used only while return is happening)
    3= Returned horse
    4= Rejected */

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nLady") == 2))
        return FALSE;

    return TRUE;
}
