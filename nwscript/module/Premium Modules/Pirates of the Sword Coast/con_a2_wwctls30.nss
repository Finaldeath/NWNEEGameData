//::///////////////////////////////////////////////
//:: con_a2_wwctls30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Delivered Willigans Cutless?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WWCTLS");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
