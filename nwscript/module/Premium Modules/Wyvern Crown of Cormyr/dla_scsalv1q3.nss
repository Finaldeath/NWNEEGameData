//B W-Husey
// October 2005
// Conditional for PC has accepted Salvatori's guard offer, but not yet left Morfen.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nSalvatori1Side") == 3))
        return FALSE;

    return TRUE;
}
