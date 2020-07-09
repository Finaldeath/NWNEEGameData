//::///////////////////////////////////////////////
//:: dla_schawk1q210
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script. HawklinPlot1 variable is less than 3
    (i.e. the PC has not yet won through the joust), but more than 0.
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if((nTemp < 3) && (nTemp > 0))
        return TRUE;

    return FALSE;
}
