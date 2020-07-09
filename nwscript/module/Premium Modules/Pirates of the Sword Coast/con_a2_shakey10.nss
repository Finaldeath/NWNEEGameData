//::///////////////////////////////////////////////
//:: con_a2_shakey10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard of Shakey McGuire?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SHAKEY");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
