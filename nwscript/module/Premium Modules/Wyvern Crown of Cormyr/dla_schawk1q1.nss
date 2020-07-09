//::///////////////////////////////////////////////
//:: dla_schawk1q1
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script. Checks if HawklinPlot1 variable is 1
    (i.e. the PC has not yet entered in the joust, but knows about it),
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp==1)
        return TRUE;

    return FALSE;
}
