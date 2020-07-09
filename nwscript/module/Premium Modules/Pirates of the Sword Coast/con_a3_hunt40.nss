//::///////////////////////////////////////////////
//:: con_a3_hunt40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has activated the Third of
    Five locations.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_HUNT");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
