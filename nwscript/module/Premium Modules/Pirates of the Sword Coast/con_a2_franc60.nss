//::///////////////////////////////////////////////
//:: con_a2_franc60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has paid Francis's debt and has
    recovered the ring.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if(iPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
