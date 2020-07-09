//PC has not cleaned out barrows
int StartingConditional()
{

    // Inspect local variables
    if((GetLocalInt(GetPCSpeaker(), "nManthiaPlot1") < 4) && (GetLocalInt(GetPCSpeaker(),"nMainPlot")<3))
        return TRUE;

    return FALSE;
}
