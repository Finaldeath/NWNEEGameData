//::///////////////////////////////////////////////
//:: con_a2_franc55
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pete is Dead.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if(iPlot >= 55)
    {
        return TRUE;
    }

    return FALSE;

}
