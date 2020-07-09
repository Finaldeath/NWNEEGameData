//December 2005
// B W-Husey
// PC has started the Theft to Order sidequest without progress. Conditional
// found on Magnus and Alice.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nToOrder") == 1))
        return FALSE;

    return TRUE;
}
