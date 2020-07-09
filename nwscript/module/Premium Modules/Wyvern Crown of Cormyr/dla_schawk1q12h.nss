//::///////////////////////////////////////////////
//:: dla_schawk1q12h
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script. Checks if HawklinPlot1 variable is 1 or 2
    (i.e. the PC has not succeeded in the joust), and the PC
    has a warhorse.
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"
int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if((nTemp > 0) && (nTemp <2) && (DLA_GetHasWarHorse(GetPCSpeaker())))
        return TRUE;

    return FALSE;
}
