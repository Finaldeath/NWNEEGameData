//December 2005
// B W-Husey
// PC can ask what to do next after confronting WL or talk about Salvatori's piracy to Hawklin.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nHawklinPlot2") > 1))
        return FALSE;

    return TRUE;
}
