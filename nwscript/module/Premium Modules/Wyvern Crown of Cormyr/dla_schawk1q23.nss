//::///////////////////////////////////////////////
//:: dla_schawk1q23
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script. HawklinPlot1 variable is 2 or 3
    (i.e. the PC has ridden in the joust)
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if((nTemp == 3) || (nTemp == 2))
        return TRUE;

    return FALSE;
}
