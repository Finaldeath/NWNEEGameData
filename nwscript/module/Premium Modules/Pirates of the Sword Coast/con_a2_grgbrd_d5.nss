//::///////////////////////////////////////////////
//:: con_a2_grgbrd_d5
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to GrogBeard
    atleast once and the Cutless has been
    stolen.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oGrogBeard = OBJECT_SELF;
    int iPlot = GetLocalInt(GetModule(), "A2_NWCTLS");
    int iReturn = FALSE;

    if ((GetLocalInt(oGrogBeard, "cac_a2_grgbrd_d5") != TRUE)
      && (iPlot >= 20))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
