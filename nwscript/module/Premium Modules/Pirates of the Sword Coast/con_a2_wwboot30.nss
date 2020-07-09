//::///////////////////////////////////////////////
//:: con_a2_wwboot30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Delivered Willigans Boots?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WWBOOT");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
