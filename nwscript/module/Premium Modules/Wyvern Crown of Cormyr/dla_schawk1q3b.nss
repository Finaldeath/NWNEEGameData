//::///////////////////////////////////////////////
//:: FileName dla_schawk1q2
//:: Created By: B W-Husey
//:: Created On: October 2005
//:: HawklinPlot1 variable is 3 (i.e. the PC has ridden and succeeded in the joust),

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp == 3)
        return TRUE;

    return FALSE;
}


