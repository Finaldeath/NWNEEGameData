//::///////////////////////////////////////////////
//:: con_a3_seige40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have driven off the invasion.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_SEIGE");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
