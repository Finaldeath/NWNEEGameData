//::///////////////////////////////////////////////
//:: con_a3_dead30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has activated all the sigils, but
    has not yet notified Kolmarr.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_DEAD");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
