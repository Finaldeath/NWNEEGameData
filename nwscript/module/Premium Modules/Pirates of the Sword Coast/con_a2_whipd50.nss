//::///////////////////////////////////////////////
//:: con_a2_whipd50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Willigan a member of the crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if(iPlot >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
