//January 2006
// B W-husey
// PC has convinced Eleanor and Latim to discuss marriage with Margery (Abduction sidequest)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAbduct") == 3))
        return FALSE;

    return TRUE;
}
