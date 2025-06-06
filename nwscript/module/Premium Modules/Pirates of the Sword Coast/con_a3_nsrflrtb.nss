//::///////////////////////////////////////////////
//:: con_a3_nsrflrtb
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC flirted with Nisar in Act 3,
    but Nisar was busy and didn't respond.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iReturn = FALSE;

    if ((GetLocalInt(oPC, "POTSC_A3_NISARROMANCEB") == TRUE)
      && (GetGender(oPC) == GENDER_FEMALE))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
