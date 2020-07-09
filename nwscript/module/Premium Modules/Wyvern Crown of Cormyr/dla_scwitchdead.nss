// The witch lord is dead
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nWitchDead") == 1)
        return TRUE;

    return FALSE;
}
