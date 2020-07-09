//::///////////////////////////////////////////////
//:: con_a2_wwctls40
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

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
