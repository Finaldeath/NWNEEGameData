//::///////////////////////////////////////////////
//:: cac_a2_grgbrd_d3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to GrogBeard
    atleast once and has started the Willigan
    plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oGrogBeard = OBJECT_SELF;
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if (iPlot >= 30)
    {
        SetLocalInt(oGrogBeard, "cac_a2_grgbrd_d3", TRUE);
    }
}
