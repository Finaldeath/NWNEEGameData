//B WoHusey
// B W-Husey
// This dialogue branch appears only once Manthia has given the information on the whereabouts of the raids.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nManthiaPlot1") == 1)
        return TRUE;

    return FALSE;
}
