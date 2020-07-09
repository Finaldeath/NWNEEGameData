//::///////////////////////////////////////////////
//:: con_a2_midrse40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Tasina left port with the Midngiht Rose?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_MIDROSE");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
