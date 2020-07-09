//December 2005
// B W-Husey
// PC has not completed the Theft to Order sidequest by reporting to Alice.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nToOrder") > 0 && GetLocalInt(GetPCSpeaker(), "nToOrder") < 6)
        return TRUE;

    return FALSE;
}
