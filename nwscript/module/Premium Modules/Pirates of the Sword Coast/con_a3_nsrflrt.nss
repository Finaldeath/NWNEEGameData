//::///////////////////////////////////////////////
//:: con_a3_nsrflrt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC flirted with Nisar in Act 3
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iReturn = FALSE;

    if ((GetLocalInt(oPC, "POTSC_A3_NISARROMANCE") == TRUE)
      && (GetGender(oPC) == GENDER_FEMALE))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
