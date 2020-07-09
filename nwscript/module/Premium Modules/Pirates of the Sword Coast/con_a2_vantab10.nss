//::///////////////////////////////////////////////
//:: con_a2_vantab10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned that Vantabular is available
    as an optional Henchmen?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_VANTAB");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
