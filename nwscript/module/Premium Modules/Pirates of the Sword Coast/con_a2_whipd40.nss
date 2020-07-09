//::///////////////////////////////////////////////
//:: con_a2_whipd40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has willigan Regained his old items?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
