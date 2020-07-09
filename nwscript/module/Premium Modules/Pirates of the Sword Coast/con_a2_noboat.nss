//::///////////////////////////////////////////////
//:: con_a2_noboat
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Tasina fled the island on the midnight
    rose and the PC has not yet agreed to crew
    the Skull and Bones for Kolmarr.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlotMROSE = GetLocalInt(GetModule(), "A2_SPNDRF");
    int iPlotSANDB = GetLocalInt(GetModule(), "A2_NECRO");

    if ((iPlotMROSE > 60) && (iPlotSANDB < 10))
    {
        return TRUE;
    }

    return FALSE;
}
