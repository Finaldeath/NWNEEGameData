//::///////////////////////////////////////////////
//:: con_a2_spndrf40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned that they may be able to
    enter the temple if they have a sufficent
    disguise.

    Pegleg Paulson seems to be holding onto just
    such an item.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;
}
