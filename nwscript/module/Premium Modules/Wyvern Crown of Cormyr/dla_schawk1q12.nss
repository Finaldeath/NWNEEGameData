//::///////////////////////////////////////////////
//:: dla_schawk1q12
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script. Checks if HawklinPlot1 variable is 1 or 2
    (i.e. the PC has net yet succeeded in the joust, but knows about it)
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp == 2 || nTemp==1)
        return TRUE;

    return FALSE;
}
