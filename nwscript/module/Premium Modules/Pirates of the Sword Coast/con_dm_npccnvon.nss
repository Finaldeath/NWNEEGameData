//::///////////////////////////////////////////////
//:: con_dm_npccnvon
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the POTSC_DM_CONVOFF option to false.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iConvOff = GetLocalInt(oModule, "POTSC_DM_CONVOFF");
    int iResult = FALSE;

    if (iConvOff == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
