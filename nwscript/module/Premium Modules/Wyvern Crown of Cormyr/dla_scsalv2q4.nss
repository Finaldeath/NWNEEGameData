// PC has fought bandit battle

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSalvatori1Side") > 3))
        return FALSE;

    return TRUE;
}
