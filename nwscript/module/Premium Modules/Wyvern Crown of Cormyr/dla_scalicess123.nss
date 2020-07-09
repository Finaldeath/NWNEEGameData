//November 2005
// B W-husey
// Spy sidequest in a state of: taken but not reported back to Alice.
// This script is found in Hawklin1 & 2 dialogue

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSpy") < 4))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nSpy") > 0))
        return FALSE;

    return TRUE;
}
