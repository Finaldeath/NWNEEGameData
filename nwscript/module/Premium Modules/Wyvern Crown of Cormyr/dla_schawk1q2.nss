//::///////////////////////////////////////////////
//:: dla_schawk1q2
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script. HawklinPlot1 variable is 2
    (i.e. the PC has ridden and failed in the joust)
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp == 2)
        return TRUE;

    return FALSE;
}
