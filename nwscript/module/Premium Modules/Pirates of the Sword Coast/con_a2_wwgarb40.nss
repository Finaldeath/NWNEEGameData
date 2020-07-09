//::///////////////////////////////////////////////
//:: con_a2_wwgarb40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Delivered Willigans Garb?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WWGARB");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
