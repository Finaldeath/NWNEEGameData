//November 2005
//B W-Husey
// Initiates if PC took the damsel sidequest and killed the damsel.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nDamsel") == 4))
        return FALSE;

    return TRUE;
}
