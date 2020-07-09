//November 2005
//B W-Husey
// Initiates if PC took the damsel sidequest. Clearly they didn't finish it as they came back
// without killing the damsel.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nDamsel") == 1))
        return FALSE;

    return TRUE;
}
