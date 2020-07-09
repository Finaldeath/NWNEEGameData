//::///////////////////////////////////////////////
//:: con_a2_wllgn_d2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC talked to Whipped Willigan atleast
    once since he's been in the Monkey's Cutless?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oWilligan = OBJECT_SELF;
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");
    int iReturn = FALSE;

    if ((GetLocalInt(oWilligan, "cac_a2_wllgn_d2") == FALSE) && (iPlot >= 50))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
