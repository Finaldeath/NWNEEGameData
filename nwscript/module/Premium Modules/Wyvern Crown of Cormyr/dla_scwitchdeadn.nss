// The witch lord is not dead
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nWitchDead") == 0)
        return TRUE;

    return FALSE;
}
