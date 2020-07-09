//::///////////////////////////////////////////////
//:: con_a3_nsrflrtf
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC Flirted in Act 0 but not
    in Act 2, and that their currently in Act 3.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    int iRomance0 = GetLocalInt(oPC, "POTSC_A0_NISARROMANCE");
    int iRomance2 = GetLocalInt(oPC, "POTSC_A2_NISARROMANCE");
    int iPlot = GetLocalInt(oModule, "A2_SPNDRF");
    int iResult = FALSE;

    if ((iPlot > 90) && (iRomance0 == TRUE) && (iRomance2 == FALSE)
      && (GetGender(oPC) == GENDER_FEMALE))
    {
        iResult = TRUE;
    }

    return iResult;
}
