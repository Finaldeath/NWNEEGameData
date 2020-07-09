//::///////////////////////////////////////////////
//:: FileName dla_schawk1q345
//:: Created By: B W-Husey
//:: Created On: October 2005
//:: HawklinPlot1 variable is -1 (i.e. the PC has ridden in the joust and failed),

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp == -1)
        return TRUE;

    return FALSE;
}
