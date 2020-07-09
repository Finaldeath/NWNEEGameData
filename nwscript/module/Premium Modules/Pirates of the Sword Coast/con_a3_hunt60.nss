//::///////////////////////////////////////////////
//:: con_a3_hunt60
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has activated all Five locations.
    Time to go talk to Kolmarr on the top of
    the hill.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_HUNT");

    if(iPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
