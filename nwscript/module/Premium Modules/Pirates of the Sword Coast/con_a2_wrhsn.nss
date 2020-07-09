//::///////////////////////////////////////////////
//:: con_a2_wrhsn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the Player still need crew members but
    has not yet entered the warehouse in
    Spindrift?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: April, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_CREW");
    int iWareHouse = GetLocalInt(GetModule(), "aen_warehouse");
    int iResult = FALSE;

    // If the crew isn't full and the warehous has not been entered
    if ((iPlot < 60) && (iWareHouse == FALSE))
    {
        iResult = TRUE;
    }

    return iResult;
}
