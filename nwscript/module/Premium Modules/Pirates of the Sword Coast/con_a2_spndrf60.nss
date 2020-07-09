//::///////////////////////////////////////////////
//:: con_a2_spndrf60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You break into the lower level of
    the Temple of Umberlee.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;
}
