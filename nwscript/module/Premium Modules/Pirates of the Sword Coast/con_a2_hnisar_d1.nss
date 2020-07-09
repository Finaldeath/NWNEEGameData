//::///////////////////////////////////////////////
//:: con_a2_hnisar_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check that the PC has Talked to Nisar once in
    Act 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oHNisar = OBJECT_SELF;
    object oModule = GetModule();

    int iDoOnce = GetLocalInt(oHNisar, "cac_a2_hnisar_d1");
    int iPlotEnd = GetLocalInt(oModule, "A2_NECRO");
    int iPlotStart = GetLocalInt(oModule, "A2_SPNDRF");
    int iReturn = FALSE;

    if ((iPlotEnd < 40) && (iPlotStart > 0) && (iDoOnce == FALSE))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
