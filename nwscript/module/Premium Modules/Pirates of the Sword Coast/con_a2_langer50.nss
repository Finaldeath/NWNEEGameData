//::///////////////////////////////////////////////
//:: con_a2_langer50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Langer has received an Extreme Pirate
    Makeover and been exonerated.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
