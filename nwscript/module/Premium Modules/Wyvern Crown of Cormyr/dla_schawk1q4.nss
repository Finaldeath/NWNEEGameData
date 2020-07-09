//::///////////////////////////////////////////////
//:: FileName dla_schawk1q4
//:: Created By: B W-Husey
//:: Created On: October 2005
//:: HawklinPlot1 variable is 4 (i.e. the PC has ridden in the joust, succeeded and told Hawklin)

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp == 4)
        return TRUE;

    return FALSE;
}
