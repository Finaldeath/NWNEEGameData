//::///////////////////////////////////////////////
//:: con_a2_wwbootn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC not delivered Willigan's Boots
    but delivered everything else?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlotBOOTS = GetLocalInt(GetModule(), "A2_WWBOOT");
    int iPlotCUTLESS = GetLocalInt(GetModule(), "A2_WWCTLS");
    int iPlotGARB = GetLocalInt(GetModule(), "A2_WWGARB");

    if ((iPlotBOOTS < 40) && (iPlotCUTLESS >= 40) && (iPlotGARB >= 40))
    {
        return TRUE;
    }

    return FALSE;

}
