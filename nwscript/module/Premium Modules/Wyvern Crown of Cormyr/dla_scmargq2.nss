//January 2006
// B W-husey
// PC has let Eleanor go (Abduction sidequest)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAbduct") == 2))
        return FALSE;

    return TRUE;
}
