//::///////////////////////////////////////////////
//:: con_a2_xpm_iou
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC spoken with Longneck Langer but not
    completed the plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if((iPlot < 30) && (iPlot >= 20))
    {
        return TRUE;
    }

    return FALSE;

}
