//::///////////////////////////////////////////////
//:: con_a0_mbsh10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has met Dela and has heard of her
    shop in the alley way by the docks
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDelaPlot = GetLocalInt(GetModule(), "A0_AMBUSH");
    int iResult = FALSE;

    if (iDelaPlot == 10)
    {
        iResult = TRUE;
    }

    return iResult;
}
