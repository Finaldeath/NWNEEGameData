// PC has taken but not yet resolved abduction quest.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAbduct") < 5))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nAbduct") > 0))
        return FALSE;

    return TRUE;
}
