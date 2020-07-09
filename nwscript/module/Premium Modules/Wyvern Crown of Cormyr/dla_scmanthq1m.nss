//B WoHusey
// B W-Husey
// This dialogue branch appears only once if the PC has not spoken to Manthis
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nManthiaPlot1") < 1)
        return TRUE;

    return FALSE;
}
