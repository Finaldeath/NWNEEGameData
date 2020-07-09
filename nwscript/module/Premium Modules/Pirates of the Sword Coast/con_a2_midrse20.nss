//::///////////////////////////////////////////////
//:: con_a2_midrse20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC seen the found the Rose in Harbor?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_MIDROSE");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
