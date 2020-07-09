//::///////////////////////////////////////////////
//:: con_a2_whipd20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the ladder to willigans room been setup
    by Grog Beard?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
