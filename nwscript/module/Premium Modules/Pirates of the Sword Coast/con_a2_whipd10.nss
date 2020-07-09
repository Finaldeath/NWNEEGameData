//::///////////////////////////////////////////////
//:: con_a2_whipd10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard of Whipped Willigan?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
