//January 2006
// B W-husey
// PC has dragged Eleanor back to mother (Abduction sidequest)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAbduct") == 4))
        return FALSE;

    return TRUE;
}
