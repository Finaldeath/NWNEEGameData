//::///////////////////////////////////////////////
//:: con_a2_grgbrd_d4
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to GrogBeard
    atleast once and Willigan is free.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oGrogBeard = OBJECT_SELF;
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");
    int iReturn = FALSE;

//    if ((GetLocalInt(oGrogBeard, "cac_a2_grgbrd_d2") != TRUE)
//      && (iPlot >= 40))
    if (iPlot >= 40)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
